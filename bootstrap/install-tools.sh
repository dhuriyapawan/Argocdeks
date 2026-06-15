#!/usr/bin/env bash

# install-tools.sh
# Installs required tools (Terraform, AWS CLI, kubectl, Helm, ArgoCD CLI)

set -euo pipefail

echo "=== Installing Kubernetes and Infrastructure Tools ==="

# Check OS and install appropriate binaries
OS_TYPE=$(uname -s | tr '[:upper:]' '[:lower:]')
ARCH_TYPE=$(uname -m)
if [ "$ARCH_TYPE" = "x86_64" ]; then
    ARCH_TYPE="amd64"
fi

# Create local bin if it doesn't exist
LOCAL_BIN="$HOME/.local/bin"
mkdir -p "$LOCAL_BIN"
export PATH="$LOCAL_BIN:$PATH"

# 1. AWS CLI (Installation message)
if ! command -v aws &> /dev/null; then
    echo "Please install AWS CLI v2 for your OS from https://aws.amazon.com/cli/"
else
    echo "AWS CLI is already installed: $(aws --version)"
fi

# 2. Terraform
if ! command -v terraform &> /dev/null; then
    echo "Installing Terraform..."
    TF_VERSION="1.7.5"
    curl -sSL "https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_${TF_VERSION}_${OS_TYPE}_${ARCH_TYPE}.zip" -o tf.zip
    unzip -o tf.zip -d "$LOCAL_BIN"
    rm tf.zip
else
    echo "Terraform is already installed: $(terraform version | head -n 1)"
fi

# 3. Kubectl
if ! command -v kubectl &> /dev/null; then
    echo "Installing kubectl..."
    KUBECTL_VERSION=$(curl -L -s https://dl.k8s.io/release/stable.txt)
    curl -LO "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/${OS_TYPE}/${ARCH_TYPE}/kubectl"
    chmod +x kubectl
    mv kubectl "$LOCAL_BIN/"
else
    echo "kubectl is already installed: $(kubectl version --client --short 2>/dev/null || kubectl version --client)"
fi

# 4. Helm
if ! command -v helm &> /dev/null; then
    echo "Installing Helm..."
    curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
    chmod +x get_helm.sh
    DESIRED_VERSION="v3.14.2" ./get_helm.sh --no-sudo
    mv /usr/local/bin/helm "$LOCAL_BIN/" || true
    rm get_helm.sh
else
    echo "Helm is already installed: $(helm version --short)"
fi

# 5. ArgoCD CLI
if ! command -v argocd &> /dev/null; then
    echo "Installing ArgoCD CLI..."
    curl -sSL -o argocd "https://github.com/argoproj/argo-cd/releases/latest/download/argocd-${OS_TYPE}-${ARCH_TYPE}"
    chmod +x argocd
    mv argocd "$LOCAL_BIN/"
else
    echo "ArgoCD CLI is already installed: $(argocd version --client --short)"
fi

echo "=== Tool Installation Completed ==="
echo "Make sure $LOCAL_BIN is in your PATH."
