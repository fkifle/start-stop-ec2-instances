resource "aws_cloudwatch_event_rule" "ec2_stop_rule" {
  name                = "StopEC2Instances"
  description         = "Stop EC2 nodes at 19:00 from Monday to friday"
  schedule_expression = "cron(0 19 ? * 2-6 *)"
}
resource "aws_cloudwatch_event_target" "ec2_stop_rule_target" {
  rule = aws_cloudwatch_event_rule.ec2_stop_rule.name
  arn  = aws_lambda_function.stop_ec2_lambda.arn
}

resource "aws_cloudwatch_event_rule" "ec2_start_rule" {
  name                = "StartEC2Instances"
  description         = "Start EC2 nodes at 6:30 from Monday to friday"
  schedule_expression = "cron(30 6 ? * 2-6 *)"
}

resource "aws_cloudwatch_event_target" "ec2_start_rule_target" {
  rule = aws_cloudwatch_event_rule.ec2_start_rule.name
  arn  = aws_lambda_function.start_ec2_lambda.arn
}