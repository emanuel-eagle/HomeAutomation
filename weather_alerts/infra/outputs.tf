output ecr_repo_name {
    value = aws_ecr_repository.weather-alerts-container-repository.repository_url
}