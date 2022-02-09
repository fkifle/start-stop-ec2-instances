data "archive_file" "lambda_archive" {
  type        = "zip"
  source_file = "${path.module}/ec2_lambda_handler.py"
  output_path = "${path.module}/ec2_lambda_handler.zip"
}


resource "aws_lambda_function" "stop_ec2_lambda" {
  filename         = "ec2_lambda_handler.zip"
  function_name    = "stopEC2Lambda"
  role             = aws_iam_role.stop_start_ec2_role.arn
  handler          = "ec2_lambda_handler.stop"
  source_code_hash = data.archive_file.lambda_archive.output_base64sha256
  runtime          = "python3.7"
  memory_size      = "250"
  timeout          = "60"
}

resource "aws_lambda_function" "start_ec2_lambda" {
  filename      = "ec2_lambda_handler.zip"
  function_name = "startEC2Lambda"
  role          = aws_iam_role.stop_start_ec2_role.arn
  handler       = "ec2_lambda_handler.start"

  source_code_hash = filebase64sha256("ec2_lambda_handler.zip")

  runtime     = "python3.7"
  memory_size = "250"
  timeout     = "60"
}