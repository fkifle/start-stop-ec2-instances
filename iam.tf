resource "aws_iam_role" "stop_start_ec2_role" {
  name               = "StopStartEC2Role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}
resource "aws_iam_role_policy_attachment" "lambda_role_policy" {
  role       = aws_iam_role.stop_start_ec2_role.name
  policy_arn = aws_iam_policy.stop_start_ec2_policy.arn
}