# Contributing Guide

Thanks for contributing to `ax-terraform-cloud-baseline`.

Contact: https://axelliant.com | info@axelliant.com | security@axelliant.com

## Development Workflow

1. Fork or branch from `main`.
2. Install tooling:
   ```bash
   make setup
   ```
3. Run checks before committing:
   ```bash
   make lint
   make test
   make smoke
   ```
4. Submit a pull request with clear scope, risk notes, and rollback guidance.

## Commit Standards

- Use Conventional Commits (`feat:`, `fix:`, `chore:`, `docs:`) to support automated release tags and changelog generation.
- Keep changes focused and reviewable.
- Include tests for functional behavior changes.

## Pull Request Requirements

- Terraform formatting and validation pass.
- Unit/integration tests pass.
- Documentation updated for user-facing behavior or interfaces.
- Security implications documented when relevant.

## Coding Standards

- Keep modules composable and environment-agnostic.
- Avoid hardcoding credentials, account IDs, or secrets.
- Prefer least privilege IAM policies.
- Keep naming/tagging conventions consistent across modules.

## Issue Reporting

For bugs and feature requests, open a GitHub issue with:
- expected behavior
- actual behavior
- reproducible steps
- relevant logs and environment details

For security issues, do not open a public issue. Email security@axelliant.com.
