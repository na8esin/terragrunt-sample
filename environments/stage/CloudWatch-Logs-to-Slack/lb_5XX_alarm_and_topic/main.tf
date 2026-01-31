module "lb_5XX_alarm_and_topic" {
  source = "../../../../module/CloudWatch-Logs-to-Slack/lb_5XX_alarm_and_topic"
  env = var.env
  app_name = var.app_name
  lb_arn_suffix = data.terraform_remote_state.lb.outputs.aws_alb_arn_suffix
}