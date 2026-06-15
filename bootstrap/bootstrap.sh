#!/usr/bin/env bash

# bootstrap.sh
# Automates the setup of infrastructure and baseline Kubernetes services.

set -euo pipefail

ENV=${1:-dev}
AWS_REGION=${2:-us-east-1}

echo "=== Starting RideShareX Bootstrapping for Environment: ${ENV} ==="

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"

# 1. Validate tools and credentials
echo "Checking pre-requisites..."
"${SCRIPT_DIR}/validate.sh"

# 2. Deploy Terraform Infrastructure
echo "Applying Terraform manifests..."
cd "${ROOT_DIR}/terraform/environments/${ENV}"

terraform init
terraform plan -out=tfplan
terraform apply tfplan

# Extract Outputs
CLUSTER_NAME=$(terraform output -raw eks_cluster_name)
ECR_REGISTRY=$(terraform output -raw ecr_registry_domain || echo "")

echo "Terraform applied. Cluster: ${CLUSTER_NAME}"

# 3. Configure Kubernetes context
echo "Updating Kubeconfig..."
aws eks update-kubeconfig --region "${AWS_REGION}" --name "${CLUSTER_NAME}"

# 4. Create Kubernetes Namespaces
echo "Creating namespaces..."
kubectl apply -f "${ROOT_DIR}/kubernetes/namespaces/"

# 5. Bootstrap ArgoCD
echo "Installing ArgoCD..."
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# Wait for ArgoCD server
echo "Waiting for ArgoCD API Server to be ready..."
kubectl rollout status deployment/argocd-server -n argocd --timeout=300s

# 6. Apply ArgoCD App-of-Apps
echo "Applying ArgoCD App-of-Apps config..."
kubectl apply -f "${ROOT_DIR}/argocd/app-of-apps/root-app.yaml"

echo "=== RideShareX Bootstrapping Complete! ==="
echo "ArgoCD is now running. Fetch the admin password using:"
echo "kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath=\"{.data.password}\" | base64 -d"
