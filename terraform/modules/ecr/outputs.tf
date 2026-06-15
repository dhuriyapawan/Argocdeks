# modules/ecr/outputs.tf

output "repository_urls" {
  description = "Map of ECR repository URLs"
  value       = { for r in aws_ecr_repository.repo : split("/", r.name)[1] => r.repository_url }
}

output "registry_id" {
  description = "The registry ID"
  value       = aws_ecr_repository.repo[0].registry_id
}
