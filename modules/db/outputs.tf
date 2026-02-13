output "db_instance_id" {
  description = "RDS instance identifier."
  value       = aws_db_instance.this.id
}

output "db_endpoint" {
  description = "RDS endpoint address."
  value       = aws_db_instance.this.address
}

output "db_security_group_id" {
  description = "Security group ID attached to the database."
  value       = aws_security_group.db.id
}

output "master_user_secret_arn" {
  description = "Secrets Manager ARN for generated master user credentials."
  value       = aws_db_instance.this.master_user_secret[0].secret_arn
}
