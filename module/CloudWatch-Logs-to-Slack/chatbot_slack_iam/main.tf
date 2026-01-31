# chatbot用のIAMロールとポリシーを作成

locals {
  env_resource_prefix = "${var.app_name}-${var.env}"
}

# roleに関する信頼ポリシー
data "aws_iam_policy_document" "chatbot_assume_role_policy" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["chatbot.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}
# role作成
resource "aws_iam_role" "chatbot" {
  name               = "${local.env_resource_prefix}-chatbot"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.chatbot_assume_role_policy.json

  tags = {
    Name    = "${local.env_resource_prefix}-chatbot-iam-role"
    Env     = var.env
    Project = var.app_name
  }
}

# ポリシー作成
data "aws_iam_policy_document" "cloudwatch_policy_for_chatbot" {
  statement {
    effect    = "Allow"
    actions   = ["cloudwatch:Describe*", "cloudwatch:Get*", "cloudwatch:List*"]
    resources = ["*"]
  }
}
resource "aws_iam_policy" "policy" {
  name   = "${local.env_resource_prefix}-chatbot"
  policy = data.aws_iam_policy_document.cloudwatch_policy_for_chatbot.json

  tags = {
    Name    = "${local.env_resource_prefix}-chatbot-policy"
    Env     = var.env
    Project = var.app_name
  }
}
# 上記で作成したポリシーをroleにアタッチ
resource "aws_iam_role_policy_attachment" "task_role_attachment1" {
  policy_arn = aws_iam_policy.policy.arn
  role       = aws_iam_role.chatbot.id
}

# aws管理ポリシーもアタッチ
resource "aws_iam_role_policy_attachment" "task_role_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonQDeveloperAccess"
  role       = aws_iam_role.chatbot.id
}
