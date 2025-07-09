resource "aws_wafv2_regex_pattern_set" "example" {
  name        = "example"
  description = "Example regex pattern set"
  scope       = "CLOUDFRONT"

  regular_expression {
    regex_string = "^(?!\\/aaa).*$"
  }

  tags = {
    Tag1 = "watanabe"
  }
}