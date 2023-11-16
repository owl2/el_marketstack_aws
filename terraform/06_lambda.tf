resource "aws_lambda_function" "lambda_marketstack" {
  filename      = local.lambda_package_path
  function_name = "marketstack_api"
  role          = aws_iam_role.lambda_marketstack_role.arn
  runtime       = "python3.9"
  handler       = "main.handler"

  source_code_hash = local.lambda_package_hash
}
