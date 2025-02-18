resource "aws_cloudwatch_event_rule" "daily_lambda" {
  name                = "trigger-lambda-daily"
  description         = "Triggers Lambda function every day at 4:30 AM EST"
  schedule_expression = "cron(30 9 * * ? *)"  # 4:30 AM EST = 9:30 UTC
}

resource "aws_cloudwatch_event_target" "lambda_target" {
  rule      = aws_cloudwatch_event_rule.daily_lambda.name
  target_id = "SendToLambda"
  arn       = aws_lambda_function.weather_alerts_lambda_function.arn
}

resource "aws_lambda_permission" "allow_eventbridge" {
  statement_id  = "AllowEventBridgeInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.weather_alerts_lambda_function.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.daily_lambda.arn
}