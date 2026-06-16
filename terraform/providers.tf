# terraform/providers.tf

provider "aws" {
  region = "us-east-1"
}

# The Kubernetes provider configuration will dynamically reference EKS outputs.
# We declare it here so environments can inherit provider definitions.
provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}
