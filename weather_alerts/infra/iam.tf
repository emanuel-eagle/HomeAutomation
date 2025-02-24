data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "iam_for_lambda" {
  name               = "lambda_to_ecr_permissions"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

data "aws_iam_policy_document" "lambda_policy_document" {

  statement {
    effect    = var.allow_string
    actions   = var.ecr_permissions_list
    resources = [aws_ecr_repository.weather-alerts-container-repository.arn]
  }

  statement {
    effect    = var.allow_string
    actions   = var.cloudwatch_permissions_list
    resources = [aws_cloudwatch_log_group.rain_alerting_cloudwatch_group.arn]
  }

}

resource "aws_iam_policy" "lambda_policy" {
  name   = "lambda-policy-rain-alert-notification"
  policy = data.aws_iam_policy_document.lambda_policy_document.json
}

resource "aws_iam_role_policy_attachment" "lambda_policy_attachment" {
  role       = aws_iam_role.iam_for_lambda.name
  policy_arn = aws_iam_policy.lambda_policy.arn
}



variable ecr_permissions_list {
    description = "Permissions for the Lambda function"
    type = list
    default = ["ecr:BatchGetImage", "ecr:GetDownloadUrlForLayer"]
}

variable cloudwatch_permissions_list {
    description = "Permissions for the Lambda function"
    type = list
    default = ["logs:CreateLogGroup", "logs:CreateLogStream", "logs:PutLogEvents"]
}

variable allow_string {
  default = "Allow"
}