# modules/security-groups/outputs.tf

output "alb_sg_id" {
  description = "Security group ID for the ALB"
  value       = aws_security_group.alb.id
}

output "eks_cluster_sg_id" {
  description = "Security group ID for the EKS Cluster control plane"
  value       = aws_security_group.eks_cluster.id
}

output "eks_nodes_sg_id" {
  description = "Security group ID for the EKS Nodes"
  value       = aws_security_group.eks_nodes.id
}

output "rds_sg_id" {
  description = "Security group ID for RDS PostgreSQL"
  value       = aws_security_group.rds.id
}

output "redis_sg_id" {
  description = "Security group ID for ElastiCache Redis"
  value       = aws_security_group.redis.id
}
