# terraform/environments/prod/outputs.tf

output "eks_cluster_name" {
  description = "The name of the EKS Cluster"
  value       = module.eks.cluster_name
}

output "eks_cluster_endpoint" {
  description = "The endpoint for EKS API"
  value       = module.eks.cluster_endpoint
}

output "alb_dns_name" {
  description = "Public ALB Endpoint"
  value       = module.alb.alb_dns_name
}

output "ecr_repository_urls" {
  description = "URLs of ECR registries"
  value       = module.ecr.repository_urls
}

output "db_endpoint" {
  description = "RDS connection string endpoint"
  value       = module.rds.db_instance_endpoint
}

output "redis_primary_endpoint" {
  description = "Redis connection address"
  value       = module.redis.redis_primary_endpoint
}
