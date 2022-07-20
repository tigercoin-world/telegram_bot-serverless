module "api_gateway" {
  source = "./terraform-aws-apigateway-v2"

  name          = "sale-api-gw"
  description   = "HTTP API gateway for the sales api"
  protocol_type = "HTTP"
  create_api_domain_name = false

  # Routes and integrations
  integrations = {
    "$default" = {
      lambda_arn = "${aws_lambda_function.tele_bot_lambda.arn}"
      payload_format_version = "2.0"
    }
  }

  tags = {
    Name = "http-apigateway"
  }
}