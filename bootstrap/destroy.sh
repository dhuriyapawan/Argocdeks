#!/usr/bin/env bash

# destroy.sh
# Destroys all Kubernetes resources and Terraform infrastructure.

set -euo pipefail

ENV=${1:-dev}

echo "=== WARNING: Starting RideShareX Destruction for Environment: ${ENV} ==="
read -p "Are you absolutely sure you want to destroy all resources? (y/N) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Destruction cancelled."
    exit 0
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"

# 1. Connect to Cluster and delete ArgoCD Applications to trigger cascade deletions
echo "Deleting ArgoCD Application of Applications (root-app)..."
kubectl delete -f "${ROOT_DIR}/argocd/app-of-apps/root-app.yaml" --ignore-not-found=true || true

echo "Deleting applications namespace (cascading app removal)..."
kubectl delete namespace rideshare --ignore-not-found=true || true

echo "Deleting monitoring namespace..."
kubectl delete namespace monitoring --ignore-not-found=true || true

echo "Deleting logging namespace..."
kubectl delete namespace logging --ignore-not-found=true || true

# 2. Run Terraform Destroy
echo "Running Terraform Destroy..."
cd "${ROOT_DIR}/terraform/environments/${ENV}"

terraform destroy -auto-approve

echo "=== RideShareX Cleanup Complete ==="
