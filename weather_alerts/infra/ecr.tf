resource "aws_ecr_repository" "weather-alerts-container-repository" {
  name                 = var.container_repo_name
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = true
  }
}

variable "container_repo_name" {
  type = string
  default = "weather-alerts-container-repository"
} 