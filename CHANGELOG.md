# Changelog

All notable changes to this project are documented in this file.

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
