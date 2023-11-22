resource "aws_cloudwatch_log_group" "lambda_marketstack" {
  name              = "/aws/lambda/${aws_lambda_function.lambda_marketstack.function_name}"
  retention_in_days = 1
}
