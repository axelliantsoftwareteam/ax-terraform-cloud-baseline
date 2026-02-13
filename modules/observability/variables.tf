variable "name" {
  description = "Name prefix for observability resources."
  type        = string
}

variable "log_retention_days" {
  description = "Retention window for CloudWatch logs."
  type        = number
  default     = 30
}

variable "alert_email" {
  description = "Email address for SNS notifications. Leave null to disable email subscription."
  type        = string
  default     = null
}

variable "tags" {
  description = "Common tags applied to all resources."
  type        = map(string)
  default     = {}
}
