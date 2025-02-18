resource "aws_ecr_repository" "home-automation-container-repository" {
  name                 = var.container_repo_name
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = true
  }
}