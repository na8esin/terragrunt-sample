# アラームの作成 -> メトリクスの選択 に出てこなくても作成できる
# CloudWatch AlarmとSNS Topicの作成

locals {
  env_resource_prefix = "${var.app_name}-${var.env}"
}

resource "aws_sns_topic" "lb_5XX" {
  name = "${local.env_resource_prefix}-lb-5XX"
  display_name = "ApplicationELB 5XX Alarm Notifications"

  tags = {
    Name    = "${local.env_resource_prefix}-sns-topic-lb-5XX"
    Env     = var.env
    Project = var.app_name
  }
}

resource "aws_cloudwatch_metric_alarm" "lb_5XX" {
  alarm_name                = "${local.env_resource_prefix}-lb_5XX"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = 2 # プロジェクトに応じて調整
  threshold                 = 5 # プロジェクトに応じて調整
  alarm_description         = "This metric monitors ALB 5XX error count"
  alarm_actions             = [
    aws_sns_topic.lb_5XX.arn
  ]
  insufficient_data_actions = []

  metric_query {
    id = "m1"
    return_data = true

    metric {
      metric_name = "HTTPCode_ELB_5XX_Count"
      namespace   = "AWS/ApplicationELB"
      period      = 60 # seconds
      stat        = "Sum"
      unit        = "Count"

      dimensions = {
        LoadBalancer = var.lb_arn_suffix
      }
    }
  }

  tags = {
    Name    = "${local.env_resource_prefix}-cw-alarm-lb-5XX"
    Env     = var.env
    Project = var.app_name
  }
}
