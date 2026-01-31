module "chatbot_slack" {
  source = "../../../../module/CloudWatch-Logs-to-Slack/chatbot_slack"
  app_name         = var.app_name
  env              = var.env
  accountId        = var.accountId
  slack_channel_id = "XXXXXXXX"  # your slack channel id
  slack_team_id    = "XXXXXXXX"  # your slack team id
}