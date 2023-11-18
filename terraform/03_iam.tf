# Set up the role
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


# Secret Manager policy
data "aws_iam_policy_document" "lambda_marketstack" {
  statement {
    effect    = "Allow"
    actions   = ["secretsmanager:GetSecretValue"]
    resources = [data.aws_secretsmanager_secret.marketstack_api.arn]
  }

  statement {
    effect    = "Allow"
    actions   = ["s3:GetObject","s3:ListBucket"]
    resources = ["${aws_s3_bucket.lmu-marketstack-poc.arn}"]
  }

  statement {
    effect    = "Allow"
    actions   = ["s3:PutObject","s3:GetObject","s3:ListBucket","s3:DeleteObject"]
    resources = ["${aws_s3_bucket.lmu-marketstack-poc.arn}/*"]
  }
}

# Create the policy and attach all the policies on it
resource "aws_iam_policy" "lambda_marketstack_policy" {
  name        = "lambda_marketstack_policy"
  description = "A policy to attach to lambda marcketstack api"
  policy      = data.aws_iam_policy_document.lambda_marketstack.json
}

resource "aws_iam_policy_attachment" "ambda_marketstack_attach" {
  name       = "ambda_marketstack_attachment"
  roles      = [aws_iam_role.lambda_marketstack_role.name]
  policy_arn = aws_iam_policy.lambda_marketstack_policy.arn
}