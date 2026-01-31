# snsサブスクリプションはこれをapplyすると自動で作成される
# sns_topic_arnsをどんどん追加していく

locals {
  env_resource_prefix = "${var.app_name}-${var.env}"
}

resource "aws_chatbot_slack_channel_configuration" "slack_error_channel" {
  configuration_name = "${local.env_resource_prefix}-error"
  iam_role_arn       = "arn:aws:iam::${var.accountId}:role/${local.env_resource_prefix}-chatbot"
  slack_channel_id   = var.slack_channel_id
  slack_team_id      = var.slack_team_id
  sns_topic_arns     = [
    "arn:aws:sns:ap-northeast-1:${var.accountId}:${local.env_resource_prefix}-lb-5XX",
  ]
  logging_level      = "ERROR"

  tags = {
    Name    = "${local.env_resource_prefix}-chatbot-slack-error-channel"
    Env     = var.env
    Project = var.app_name
  }
}