variable "project_name" {
  description = "Project identifier used in naming and tags."
  type        = string
  default     = "ax-terraform-cloud-baseline"
}

variable "environment" {
  description = "Deployment environment name (dev, stage, prod)."
  type        = string
}

variable "aws_region" {
  description = "AWS region for this environment."
  type        = string
}

variable "availability_zones" {
  description = "Availability zones used for subnet placement."
  type        = list(string)
}

variable "vpc_cidr" {
  description = "CIDR block allocated for the environment VPC."
  type        = string
}

variable "owner" {
  description = "Team owner for tagging and governance."
  type        = string
}

variable "cost_center" {
  description = "Cost center identifier for tagging and chargeback."
  type        = string
}

variable "alert_email" {
  description = "Security/operations alert email."
  type        = string
  default     = null
}

variable "db_instance_class" {
  description = "RDS instance class by environment."
  type        = string
}

variable "db_multi_az" {
  description = "Enable Multi-AZ RDS in this environment."
  type        = bool
  default     = false
}

variable "endpoint_public_access" {
  description = "Expose EKS API endpoint publicly when true."
  type        = bool
  default     = false
}
