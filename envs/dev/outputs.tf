output "vpc_id" {
  description = "Environment VPC ID."
  value       = module.network.vpc_id
}

output "eks_cluster_name" {
  description = "EKS cluster name."
  value       = module.k8s.cluster_name
}

output "db_endpoint" {
  description = "RDS endpoint for private application connectivity."
  value       = module.db.db_endpoint
}

output "db_secret_arn" {
  description = "Secrets Manager ARN for DB master credential."
  value       = module.db.master_user_secret_arn
}

output "alerts_topic_arn" {
  description = "SNS topic ARN for environment alerts."
  value       = module.observability.alerts_topic_arn
}
