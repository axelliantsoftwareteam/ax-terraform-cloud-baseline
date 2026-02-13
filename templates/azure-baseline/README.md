# Azure Baseline Template

This folder provides a documented Azure Terraform starter template for organizations standardizing multi-cloud operations from a single repository.

## Scope

- Creates a resource group and virtual network as a baseline scaffold.
- Mirrors naming and tagging conventions used in the AWS implementation.
- Intended as a starting point for adding AKS, Azure Database for PostgreSQL, and Azure Monitor components.

## Usage

```bash
cd templates/azure-baseline
terraform init
terraform plan -var='environment=dev' -var='location=eastus'
```

## Security Notes

- Keep production workloads in private subnets and private endpoints.
- Use Azure Key Vault for secrets and avoid credentials in `*.tfvars`.
- Align RBAC with least-privilege role assignments by team and workload.

Contact: https://axelliant.com | info@axelliant.com | security@axelliant.com
