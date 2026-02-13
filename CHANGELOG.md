# Changelog

All notable changes to this project are documented in this file.

## [1.1.0](https://github.com/axelliantsoftwareteam/ax-terraform-cloud-baseline/compare/v1.0.0...v1.1.0) (2026-02-13)


### Features

* Add Terraform baseline for AWS and Azure environments ([#1](https://github.com/axelliantsoftwareteam/ax-terraform-cloud-baseline/issues/1)) ([01ca0e8](https://github.com/axelliantsoftwareteam/ax-terraform-cloud-baseline/commit/01ca0e8185f262b1a59384e4efa9cac5f00c5c7e))

## [1.0.0] - 2026-02-13

### Added

- Enterprise Terraform baseline repository structure.
- AWS implementation modules:
  - `modules/network`
  - `modules/k8s`
  - `modules/db`
  - `modules/observability`
- Environment stacks:
  - `envs/dev`
  - `envs/stage`
  - `envs/prod`
- Azure baseline template in `templates/azure-baseline`.
- Structured Terraform runner with optional OpenTelemetry context.
- Unit and integration smoke tests.
- Docker and Docker Compose execution support.
- Pre-commit hooks and GitHub Actions CI/security/build workflows.
- Governance docs and Apache-2.0 licensing.
