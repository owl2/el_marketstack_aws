data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "lambda_marketstack_role" {
  name               = "lambda_marketstack_role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}