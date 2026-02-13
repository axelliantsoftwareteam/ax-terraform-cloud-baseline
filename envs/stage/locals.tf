locals {
  name_prefix = "${var.project_name}-${var.environment}"

  standard_tags = {
    Project     = var.project_name
    Environment = var.environment
    Owner       = var.owner
    CostCenter  = var.cost_center
    ManagedBy   = "Terraform"
    DataClass   = "Internal"
  }
}
