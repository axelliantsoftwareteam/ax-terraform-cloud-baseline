variable "name" {
  description = "Name prefix for Kubernetes resources."
  type        = string
}

variable "vpc_id" {
  description = "VPC identifier that will host the EKS cluster."
  type        = string
}

variable "private_subnet_ids" {
  description = "Private subnet identifiers used by the EKS control plane and nodes."
  type        = list(string)
}

variable "cluster_version" {
  description = "EKS cluster version."
  type        = string
  default     = "1.30"
}

variable "endpoint_public_access" {
  description = "Enables public API server access when true."
  type        = bool
  default     = false
}

variable "node_instance_types" {
  description = "Managed node group instance types."
  type        = list(string)
  default     = ["t3.medium"]
}

variable "node_desired_size" {
  description = "Desired number of worker nodes."
  type        = number
  default     = 2
}

variable "node_min_size" {
  description = "Minimum number of worker nodes."
  type        = number
  default     = 1
}

variable "node_max_size" {
  description = "Maximum number of worker nodes."
  type        = number
  default     = 3
}

variable "tags" {
  description = "Common tags applied to all resources."
  type        = map(string)
  default     = {}
}
