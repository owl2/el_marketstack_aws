resource "aws_s3_bucket" "lmu-marketstack-poc" {
  bucket = "lmu-marketstack-poc"

  tags = {
    Name        = "project"
    Environment = "aws_glue_heads_on"
  }
}