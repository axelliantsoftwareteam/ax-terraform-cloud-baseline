output "vpc_id" {
  description = "VPC identifier."
  value       = aws_vpc.this.id
}

output "vpc_cidr" {
  description = "VPC CIDR range."
  value       = aws_vpc.this.cidr_block
}

output "private_subnet_ids" {
  description = "Private subnet identifiers used for workloads."
  value       = [for subnet in values(aws_subnet.private) : subnet.id]
}

output "private_subnet_cidrs" {
  description = "Private subnet CIDR blocks."
  value       = [for subnet in values(aws_subnet.private) : subnet.cidr_block]
}

output "db_subnet_ids" {
  description = "Dedicated database subnet identifiers."
  value       = [for subnet in values(aws_subnet.db) : subnet.id]
}

output "db_subnet_cidrs" {
  description = "Dedicated database subnet CIDR blocks."
  value       = [for subnet in values(aws_subnet.db) : subnet.cidr_block]
}
