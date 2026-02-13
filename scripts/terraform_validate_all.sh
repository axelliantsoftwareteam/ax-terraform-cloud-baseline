#!/usr/bin/env bash
set -euo pipefail

if ! command -v terraform >/dev/null 2>&1; then
  echo "terraform is required for smoke validation" >&2
  exit 1
fi

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

run_validate() {
  local tf_dir="$1"
  echo "==> validating ${tf_dir}"
  terraform -chdir="${tf_dir}" init -backend=false -input=false -upgrade >/dev/null
  terraform -chdir="${tf_dir}" validate
}

while IFS= read -r tf_dir; do
  run_validate "${tf_dir}"
done < <(find "${ROOT_DIR}/modules" "${ROOT_DIR}/envs" -mindepth 1 -maxdepth 1 -type d | sort)

echo "Terraform module and environment smoke validation passed."
