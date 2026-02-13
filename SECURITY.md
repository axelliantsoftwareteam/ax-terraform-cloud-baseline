# Security Policy

Contact: https://axelliant.com | info@axelliant.com | security@axelliant.com

## Supported Versions

Security fixes are applied to the latest `main` branch.

## Reporting a Vulnerability

Send reports to security@axelliant.com with:
- vulnerability description
- affected module/path
- reproduction steps
- potential impact
- proposed mitigation (if available)

Please avoid public disclosure until remediation is available.

## Security Baseline Principles

- Private networking by default for workload and data-plane components.
- Secrets managed in external secret systems (AWS Secrets Manager).
- Least privilege IAM access for automation and operators.
- Infrastructure changes validated by CI before merge.

## Secrets Handling

- Never commit real credentials, tokens, or backend secrets.
- Use `.env.example` and `*.tfvars.example` for safe templates only.
- Keep real values in secure secret managers and CI secret stores.
