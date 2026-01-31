module "chatbot_slack_iam" {
  source = "../../../../module/CloudWatch-Logs-to-Slack/chatbot_slack_iam"
  env = var.env
  app_name = var.app_name
}