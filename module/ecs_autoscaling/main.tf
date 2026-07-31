locals {
  env_resource_prefix = "${var.app_name}-${var.env}"
}

resource "aws_appautoscaling_target" "ecs_target" {
  max_capacity       = var.max_capacity
  min_capacity       = var.min_capacity
  resource_id        = "service/${local.env_resource_prefix}-ecs-cluster/${local.env_resource_prefix}-app-service"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"

  tags = {
    Name    = "${local.env_resource_prefix}-ecs-autoscaling-target"
    Env     = var.env
    Project = var.app_name
  }
}

# 平日夜間(20:00 JST)にdesired-countを0へ。金曜夜に0になった後は月曜朝まで再開されないため土日も自動的に停止状態を維持する。
resource "aws_appautoscaling_scheduled_action" "scale_down_night" {
  count = var.enable_night_weekend_shutdown ? 1 : 0

  name               = "${local.env_resource_prefix}-scale-down-night"
  service_namespace  = aws_appautoscaling_target.ecs_target.service_namespace
  resource_id        = aws_appautoscaling_target.ecs_target.resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_target.scalable_dimension
  schedule           = "cron(0 20 ? * MON-FRI *)"
  timezone           = "Asia/Tokyo"

  scalable_target_action {
    min_capacity = 0
    max_capacity = 0
  }
}

# 平日朝(8:00 JST)に元のcapacityへ復帰
resource "aws_appautoscaling_scheduled_action" "scale_up_morning" {
  count = var.enable_night_weekend_shutdown ? 1 : 0

  name               = "${local.env_resource_prefix}-scale-up-morning"
  service_namespace  = aws_appautoscaling_target.ecs_target.service_namespace
  resource_id        = aws_appautoscaling_target.ecs_target.resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_target.scalable_dimension
  schedule           = "cron(0 8 ? * MON-FRI *)"
  timezone           = "Asia/Tokyo"

  scalable_target_action {
    min_capacity = var.min_capacity
    max_capacity = var.max_capacity
  }
}
