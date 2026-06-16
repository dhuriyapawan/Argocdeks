# modules/eks/main.tf

resource "aws_eks_cluster" "main" {
  name     = "${var.environment}-cluster"
  role_arn = var.cluster_role_arn
  version  = var.cluster_version

  vpc_config {
    subnet_ids              = var.private_subnet_ids
    security_group_ids      = [var.cluster_security_group_id]
    endpoint_private_access = true
    endpoint_public_access  = true
  }

  encryption_config {
    resources = ["secrets"]
    provider {
      key_arn = var.kms_key_arn
    }
  }

  depends_on = [
    var.cluster_role_dependency
  ]

  tags = var.tags
}

# OIDC Provider to support IRSA
data "tls_certificate" "eks" {
  url = aws_eks_cluster.main.identity[0].oidc[0].issuer
}

resource "aws_iam_openid_connect_provider" "eks" {
  client_id_list = ["sts.amazonaws.com"]

  thumbprint_list = [data.tls_certificate.eks.certificates[0].sha1_fingerprint]

  url = aws_eks_cluster.this.identity[0].oidc[0].issuer
}