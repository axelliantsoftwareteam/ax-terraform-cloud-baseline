variable "project_name" {
  description = "Project identifier used for resource naming."
  type        = string
  default     = "ax-terraform-cloud-baseline"
}

variable "environment" {
  description = "Deployment environment identifier."
  type        = string
}

variable "location" {
  description = "Azure region for the resource group and networking stack."
  type        = string
}
