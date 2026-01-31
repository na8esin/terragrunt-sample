# このgithubリポジトリ内には、ELBのtfファイルはありません。すいません。
data "terraform_remote_state" "lb" {
  backend = "s3"

  config = {
    bucket = "${var.app_name}-${var.env}-tfstate"
    key    = "loadbalancer-tf-state"
    region = "ap-northeast-1"
  }
}
