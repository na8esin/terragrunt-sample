module "codebuild_ecr_policy" {
  source = "../../../module/codebuild_ecr_policy"

  codebuild_service_role_name = "codebuild-watanabe-service-role"
  ecr_repository_arn          = "arn:aws:ecr:ap-northeast-1:${var.aws_account_id}:repository/watanabe/sample"
}
