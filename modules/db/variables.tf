variable "name" {
  description = "Name prefix for database resources."
  type        = string
}

variable "vpc_id" {
  description = "VPC identifier for database security group placement."
  type        = string
}

variable "subnet_ids" {
  description = "Subnet identifiers used for the DB subnet group."
  type        = list(string)
}

variable "allowed_cidr_blocks" {
  description = "CIDR blocks allowed to reach the database port."
  type        = list(string)
}

variable "db_name" {
  description = "Initial database name."
  type        = string
  default     = "app"
}

variable "username" {
  description = "Master username for the database."
  type        = string
  default     = "axadmin"
}

variable "instance_class" {
  description = "RDS instance class."
  type        = string
  default     = "db.t4g.micro"
}

variable "allocated_storage" {
  description = "Allocated storage in GiB."
  type        = number
  default     = 20
}

variable "engine_version" {
  description = "PostgreSQL engine version."
  type        = string
  default     = "16.3"
}

variable "backup_retention_days" {
  description = "Backup retention in days."
  type        = number
  default     = 7
}

variable "deletion_protection" {
  description = "Prevents accidental deletion when true."
  type        = bool
  default     = true
}

variable "multi_az" {
  description = "Deploys RDS in Multi-AZ mode when true."
  type        = bool
  default     = false
}

variable "tags" {
  description = "Common tags applied to all resources."
  type        = map(string)
  default     = {}
}
