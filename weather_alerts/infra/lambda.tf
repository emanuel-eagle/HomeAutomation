variable package_type {
    description = "Name of the lambda function"
    type = string
    default = "Image"
}

locals {
  webhook_url = jsondecode(data.aws_secretsmanager_secret_version.current.secret_string)["RAIN_NOTIFICATION_WEBHOOK"]
}

resource "aws_lambda_function" "weather_alerts_lambda_function" {
  function_name = var.lambda_function_name
  role          = aws_iam_role.iam_for_lambda.arn
  image_uri     = "${aws_ecr_repository.weather-alerts-container-repository.repository_url}:latest"
  package_type = var.package_type
  timeout = 60
  memory_size = 512
  environment {
    variables = {
      NWS_URL = var.NWS_URL_BOS
      ALERT_RANGE = var.ALERT_RANGE
      WEBHOOK_URL = local.webhook_url
    }
  }
}