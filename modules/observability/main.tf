locals {
  base_tags = merge(var.tags, {
    module = "observability"
  })
}

resource "aws_cloudwatch_log_group" "application" {
  name              = "/ax/${var.name}/application"
  retention_in_days = var.log_retention_days

  tags = merge(local.base_tags, {
    Name = "${var.name}-application-logs"
  })
}

resource "aws_sns_topic" "alerts" {
  name = "${var.name}-alerts"

  tags = merge(local.base_tags, {
    Name = "${var.name}-alerts"
  })
}

resource "aws_sns_topic_subscription" "email" {
  count = var.alert_email == null ? 0 : 1

  topic_arn = aws_sns_topic.alerts.arn
  protocol  = "email"
  endpoint  = var.alert_email
}

resource "aws_cloudwatch_log_metric_filter" "error_count" {
  name           = "${var.name}-error-count"
  pattern        = "ERROR"
  log_group_name = aws_cloudwatch_log_group.application.name

  metric_transformation {
    name      = "${var.name}-ErrorCount"
    namespace = "AxBaseline"
    value     = "1"
  }
}

resource "aws_cloudwatch_metric_alarm" "error_alarm" {
  alarm_name          = "${var.name}-error-alarm"
  alarm_description   = "Alerts when ERROR logs exceed threshold"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = aws_cloudwatch_log_metric_filter.error_count.metric_transformation[0].name
  namespace           = aws_cloudwatch_log_metric_filter.error_count.metric_transformation[0].namespace
  period              = 300
  statistic           = "Sum"
  threshold           = 5
  treat_missing_data  = "notBreaching"
  alarm_actions       = [aws_sns_topic.alerts.arn]

  tags = local.base_tags
}
