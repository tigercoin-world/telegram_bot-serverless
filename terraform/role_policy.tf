resource "aws_iam_role" "tele_bot_role" {
  name               = "tele_bot_role"
  assume_role_policy = jsonencode({

  "Version": "2012-10-17",
  "Statement": {
    "Action": "sts:AssumeRole"
    "Principal": {
      "Service": "lambda.amazonaws.com"
    },
    "Effect": "Allow"
  }
})
}

data "aws_iam_policy_document" "tele_bot_policy" {
  statement {
    sid       = ""
    actions   = [
      "sns:*",
      "sqs:*",
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = [
      "arn:aws:logs:*:*:*"
    ]
  }
}

resource "aws_iam_policy" "policy" {
  name   = "policy"
  policy = data.aws_iam_policy_document.tele_bot_policy.json
}

resource "aws_iam_role_policy_attachment" "POLICY_ATTACHMENT" {
  role       = aws_iam_role.tele_bot_role.name
  policy_arn = aws_iam_policy.policy.arn
}
