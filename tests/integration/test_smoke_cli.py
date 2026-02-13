import json
import subprocess
import sys


def test_cli_dry_run_plan_smoke() -> None:
    result = subprocess.run(
        [sys.executable, "tools/tf_runner.py", "plan", "--env", "dev", "--dry-run"],
        check=False,
        capture_output=True,
        text=True,
    )

    assert result.returncode == 0
    output_lines = [line for line in result.stdout.splitlines() if line.strip()]
    assert len(output_lines) >= 2

    payload = json.loads(output_lines[-1])
    assert payload["event"] == "dry_run"
    assert "terraform" in payload["command"]
    assert "-chdir=" in payload["command"]
