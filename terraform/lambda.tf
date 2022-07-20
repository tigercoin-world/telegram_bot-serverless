resource "aws_lambda_function" "tele_bot_lambda" {
  function_name    = "tele_bot_lambda"
  filename         = "${path.module}/src/src.zip"
  handler          = "handler.handler"
  role             = aws_iam_role.tele_bot_role.arn
  runtime          = "nodejs14.x"
  memory_size      = 128
  timeout          = 1
  publish          = true

  environment {
    variables = {
      TOKEN = var.TOKEN
    }
  }
}

resource "aws_lambda_permission" "tele_bot_apigw" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.tele_bot_lambda.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "arn:aws:execute-api:${var.myregion}:${var.account-id}:${module.api_gateway.apigatewayv2_api_id}/*"
}