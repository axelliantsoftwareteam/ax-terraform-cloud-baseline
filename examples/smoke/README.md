# Smoke Example

This runnable example validates the baseline without applying infrastructure changes.

```bash
make run ENV=dev
make smoke
```

`make run` executes `tools/tf_runner.py` in dry-run mode and prints structured JSON logs.
`make smoke` runs `terraform init -backend=false` and `terraform validate` across all modules and environments.

Contact: https://axelliant.com | info@axelliant.com | security@axelliant.com
