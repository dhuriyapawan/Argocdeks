# modules/eks/nodegroups.tf

resource "aws_eks_node_group" "system" {
  cluster_name    = aws_eks_cluster.main.name
  node_group_name = "${var.environment}-system-node-group"
  node_role_arn   = var.node_role_arn
  subnet_ids      = var.private_subnet_ids

  scaling_config {
    desired_size = var.system_node_desired_size
    max_size     = var.system_node_max_size
    min_size     = var.system_node_min_size
  }

  update_config {
    max_unavailable = 1
  }

  instance_types = ["t3.medium"]
  capacity_type  = "ON_DEMAND"

  labels = {
    role = "system"
  }

  tags = merge(
    var.tags,
    {
      Name = "${var.environment}-system-nodes"
    }
  )

  lifecycle {
    ignore_changes = [scaling_config[0].desired_size]
  }
}

resource "aws_eks_node_group" "application" {
  cluster_name    = aws_eks_cluster.main.name
  node_group_name = "${var.environment}-app-node-group"
  node_role_arn   = var.node_role_arn
  subnet_ids      = var.private_subnet_ids

  scaling_config {
    desired_size = var.app_node_desired_size
    max_size     = var.app_node_max_size
    min_size     = var.app_node_min_size
  }

  update_config {
    max_unavailable = 1
  }

  instance_types = ["t3.large"]
  capacity_type  = "ON_DEMAND" # Or SPOT for cost efficiency in non-prod

  labels = {
    role = "application"
  }

  tags = merge(
    var.tags,
    {
      Name = "${var.environment}-app-nodes"
    }
  )

  lifecycle {
    ignore_changes = [scaling_config[0].desired_size]
  }
}
