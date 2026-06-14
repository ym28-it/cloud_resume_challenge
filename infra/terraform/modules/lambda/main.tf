resource "aws_lambda_function" "this" {
  function_name = "visitor_counter"
  package_type  = "Zip"
  runtime       = "python3.12"
  handler       = "lambda_function.lambda_handler"
  role          = var.lambda_role_arn

  memory_size = 128
  timeout     = 3
  ephemeral_storage {
    size = 512
  }

  filename = "dummy.zip"

  lifecycle {
    ignore_changes = [filename, source_code_hash]
  }
}

resource "aws_cloudwatch_log_group" "this" {
  name = "/aws/lambda/visitor_counter"
}
