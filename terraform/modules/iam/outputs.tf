# modules/iam/outputs.tf

output "eks_cluster_role_arn" {
  description = "EKS Cluster Control Plane IAM Role ARN"
  value       = aws_iam_role.eks_cluster.arn
}

output "eks_node_role_arn" {
  description = "EKS Node Group IAM Role ARN"
  value       = aws_iam_role.eks_nodes.arn
}

output "aws_lb_controller_role_arn" {
  description = "AWS Load Balancer Controller IAM Role ARN"
  value       = aws_iam_role.aws_lb_controller.arn
}

output "karpenter_role_arn" {
  description = "Karpenter Controller IAM Role ARN"
  value       = aws_iam_role.karpenter.arn
}
