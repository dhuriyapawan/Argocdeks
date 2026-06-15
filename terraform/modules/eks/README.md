# EKS Terraform Module

This module sets up:
- AWS EKS Cluster
- OpenID Connect (OIDC) provider for IAM Roles for Service Accounts (IRSA)
- System Node Group (for Kubernetes administrative workloads like CoreDNS, ArgoCD)
- Application Node Group (for Microservice workloads)
- AWS EKS Core Addons: vpc-cni, kube-proxy, coredns
