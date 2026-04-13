# CodeBuildサービスロールにECR操作権限を付与する

# ECRログイン用ポリシー（GetAuthorizationTokenはリソース指定不可のため * を使用）
data "aws_iam_policy_document" "ecr_auth" {
  statement {
    effect    = "Allow"
    actions   = ["ecr:GetAuthorizationToken"]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "ecr_auth" {
  name   = "codebuild-ecr-auth-policy"
  policy = data.aws_iam_policy_document.ecr_auth.json
}

resource "aws_iam_role_policy_attachment" "ecr_auth" {
  role       = var.codebuild_service_role_name
  policy_arn = aws_iam_policy.ecr_auth.arn
}

# ECRリポジトリへのpush権限
data "aws_iam_policy_document" "ecr_push" {
  statement {
    effect = "Allow"
    actions = [
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "ecr:PutImage",
      "ecr:InitiateLayerUpload",
      "ecr:UploadLayerPart",
      "ecr:CompleteLayerUpload",
    ]
    resources = [var.ecr_repository_arn]
  }
}

resource "aws_iam_policy" "ecr_push" {
  name   = "codebuild-ecr-push-policy"
  policy = data.aws_iam_policy_document.ecr_push.json
}

resource "aws_iam_role_policy_attachment" "ecr_push" {
  role       = var.codebuild_service_role_name
  policy_arn = aws_iam_policy.ecr_push.arn
}
