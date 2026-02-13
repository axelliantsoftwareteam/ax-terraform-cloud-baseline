output "log_group_name" {
  description = "Primary application log group name."
  value       = aws_cloudwatch_log_group.application.name
}

output "alerts_topic_arn" {
  description = "SNS topic ARN for alerts."
  value       = aws_sns_topic.alerts.arn
}
