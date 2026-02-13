import json
from pathlib import Path

import pytest

from ax_baseline import tf_runner


def test_environment_dir_resolves_repo_path() -> None:
    env_dir = tf_runner.environment_dir("dev")
    assert env_dir == Path.cwd() / "envs" / "dev"


def test_build_command_for_plan_contains_expected_flags() -> None:
    command = tf_runner.build_command(
        action="plan",
        environment="stage",
        var_file="/tmp/stage.tfvars",
        plan_file="/tmp/stage.tfplan",
        backend_config="",
        auto_approve=False,
    )

    assert command[0] == "terraform"
    assert any(part.startswith("-chdir=") and part.endswith("/envs/stage") for part in command)
    assert "plan" in command
    assert "-var-file=/tmp/stage.tfvars" in command
    assert "-out=/tmp/stage.tfplan" in command


def test_log_event_emits_json(
    monkeypatch: pytest.MonkeyPatch,
    capsys: pytest.CaptureFixture[str],
) -> None:
    monkeypatch.setenv("OTEL_EXPORTER_OTLP_ENDPOINT", "http://otel-collector:4317")
    context = tf_runner.build_otel_context()

    tf_runner.log_event("info", "unit_test", "structured logging", context, sample="value")
    captured = capsys.readouterr().out.strip()

    payload = json.loads(captured)
    assert payload["event"] == "unit_test"
    assert payload["sample"] == "value"
    assert payload["otel_endpoint"] == "http://otel-collector:4317"
    assert "trace_id" in payload
