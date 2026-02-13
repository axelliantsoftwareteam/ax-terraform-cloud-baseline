from __future__ import annotations

import argparse
import json
import os
import subprocess
import sys
import uuid
from datetime import UTC, datetime
from pathlib import Path
from typing import Any

VALID_ENVS = ("dev", "stage", "prod")


def repository_root() -> Path:
    return Path(__file__).resolve().parents[2]


def environment_dir(environment: str) -> Path:
    if environment not in VALID_ENVS:
        allowed_envs = ", ".join(VALID_ENVS)
        raise ValueError(
            f"Unsupported environment '{environment}'. "
            f"Expected one of: {allowed_envs}"
        )
    return repository_root() / "envs" / environment


def build_otel_context() -> dict[str, str]:
    endpoint = os.getenv("OTEL_EXPORTER_OTLP_ENDPOINT")
    if not endpoint:
        return {}

    trace_id = os.getenv("OTEL_TRACE_ID", uuid.uuid4().hex)
    return {
        "otel_endpoint": endpoint,
        "trace_id": trace_id,
    }


def log_event(
    level: str,
    event: str,
    message: str,
    context: dict[str, Any] | None = None,
    **fields: Any,
) -> None:
    payload: dict[str, Any] = {
        "timestamp": datetime.now(UTC).isoformat(),
        "level": level,
        "event": event,
        "message": message,
    }

    if context:
        payload.update(context)
    if fields:
        payload.update(fields)

    print(json.dumps(payload, sort_keys=True))


def build_command(
    action: str,
    environment: str,
    var_file: str,
    plan_file: str,
    backend_config: str,
    auto_approve: bool,
) -> list[str]:
    env_path = environment_dir(environment)
    base = ["terraform", f"-chdir={env_path}"]

    if action == "bootstrap":
        command = base + ["init", "-input=false", "-upgrade"]
        if backend_config:
            command.append(f"-backend-config={backend_config}")
        return command

    if action == "plan":
        return base + ["plan", "-input=false", f"-var-file={var_file}", f"-out={plan_file}"]

    if action == "apply":
        command = base + ["apply", "-input=false"]
        if plan_file:
            command.append(plan_file)
        else:
            command.append(f"-var-file={var_file}")
        if auto_approve:
            command.append("-auto-approve")
        return command

    raise ValueError(f"Unsupported action '{action}'.")


def run_command(command: list[str], dry_run: bool, log_context: dict[str, str]) -> int:
    command_text = " ".join(command)

    if dry_run:
        log_event(
            "info",
            "dry_run",
            "Skipping execution because dry-run is enabled.",
            log_context,
            command=command_text,
        )
        return 0

    log_event(
        "info",
        "command_start",
        "Executing Terraform command.",
        log_context,
        command=command_text,
    )
    completed = subprocess.run(command, check=False)

    if completed.returncode == 0:
        log_event(
            "info",
            "command_success",
            "Terraform command completed successfully.",
            log_context,
            exit_code=0,
        )
    else:
        log_event(
            "error",
            "command_failure",
            "Terraform command failed.",
            log_context,
            exit_code=completed.returncode,
        )

    return completed.returncode


def parse_args(argv: list[str]) -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        prog="tf-runner",
        description="Safe Terraform workflow wrapper for Axelliant cloud baseline environments.",
    )

    subparsers = parser.add_subparsers(dest="action", required=True)

    for action_name in ("bootstrap", "plan", "apply"):
        sub = subparsers.add_parser(action_name)
        sub.add_argument("--env", choices=VALID_ENVS, required=True, help="Target environment.")
        sub.add_argument(
            "--var-file",
            default="terraform.tfvars",
            help="Terraform variable file name relative to env directory.",
        )
        sub.add_argument(
            "--plan-file",
            default="tfplan",
            help="Terraform plan file name relative to env directory.",
        )
        sub.add_argument(
            "--dry-run",
            action="store_true",
            help="Print command without executing it.",
        )

    bootstrap = subparsers.choices["bootstrap"]
    bootstrap.add_argument(
        "--backend-config",
        default="backend.hcl",
        help="Backend configuration file name relative to env directory.",
    )

    apply = subparsers.choices["apply"]
    apply.add_argument(
        "--auto-approve",
        action="store_true",
        help="Bypass interactive approval for apply.",
    )

    return parser.parse_args(argv)


def resolve_env_file(environment: str, filename: str) -> str:
    return str(environment_dir(environment) / filename)


def main(argv: list[str] | None = None) -> int:
    args = parse_args(argv or sys.argv[1:])
    otel_context = build_otel_context()

    backend_config = ""
    if args.action == "bootstrap":
        backend_config = resolve_env_file(args.env, args.backend_config)

    plan_file_path = resolve_env_file(args.env, args.plan_file)
    var_file_path = resolve_env_file(args.env, args.var_file)

    command = build_command(
        action=args.action,
        environment=args.env,
        var_file=var_file_path,
        plan_file=plan_file_path,
        backend_config=backend_config,
        auto_approve=getattr(args, "auto_approve", False),
    )

    log_event(
        "info",
        "workflow_start",
        "Starting Terraform workflow command.",
        otel_context,
        action=args.action,
        environment=args.env,
    )
    return run_command(command, args.dry_run, otel_context)


if __name__ == "__main__":
    raise SystemExit(main())
