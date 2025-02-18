variable package_type {
    description = "Name of the lambda function"
    type = string
    default = "Image"
}

resource "aws_lambda_function" "weather_alerts_lambda_function" {
  function_name = var.lambda_function_name
  role          = aws_iam_role.iam_for_lambda.arn
  image_uri     = "${aws_ecr_repository.repo.repository_url}:latest"
  package_type = var.package_type
  environment {
    variables = {
      NWS_URL = var.NWS_URL_BOS
      ALERT_RANGE = var.ALERT_RANGE
      WEBHOOK_URL = var.RAIN_NOTIFICATION_WEBHOOK
    }
  }
}