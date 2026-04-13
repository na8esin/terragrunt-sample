# terragrunt sample

## 手順
```
aws sso login --sso-session $your_session_name

docker-compose run --rm terragrunt

terragrunt init
```

## CodeBuild がホストする GitHub Actions ランナーでサポートされているコンピューティングイメージ
https://docs.aws.amazon.com/ja_jp/codebuild/latest/userguide/sample-github-action-runners-update-yaml.images.html

## image
public.ecr.aws/codebuild/amazonlinux-aarch64-lambda-standard:ruby3.4