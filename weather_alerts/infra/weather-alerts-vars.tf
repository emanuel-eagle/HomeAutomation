data "aws_secretsmanager_secret" "existing_secret" {
  name = "homeautomation/prod/iftt_rain_alert_webhook"
}

data "aws_secretsmanager_secret_version" "current" {
  secret_id = data.aws_secretsmanager_secret.existing_secret.id
}

variable "RAIN_NOTIFICATION_WEBHOOK" {
  sensitive = true
  type      = string
}

variable ALERT_RANGE {
    type = number
    default = 18
}

variable NWS_URL_BOS {
    type = string
    default  = "https://api.weather.gov/gridpoints/BOX/42,71/forecast/hourly?units=us" 
}

variable lambda_function_name {
    type = string
    default = "weather_alerts"
}

variable lambda_timeout {
    type = number
    default = 10
}

variable memory_size {
    type = number
    default = 128
}

variable lambda_image_tag {
  type = string
}


