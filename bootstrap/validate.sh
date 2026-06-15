#!/usr/bin/env bash

# validate.sh
# Checks if the required local binaries are available and AWS CLI is configured.

set -euo pipefail

echo "=== Running Environment Validation ==="
FAILED=0

# Check commands
commands=(aws terraform kubectl helm argocd)

for cmd in "${commands[@]}"; do
    if command -v "$cmd" &> /dev/null; then
        echo "[OK] Found $cmd: $($cmd version --client --short 2>/dev/null || $cmd version | head -n 1)"
    else
        echo "[ERROR] Missing command: $cmd"
        FAILED=1
    fi
done

# Check AWS credentials
if command -v aws &> /dev/null; then
    if aws sts get-caller-identity --timeout 5 &> /dev/null; then
        IDENTITY=$(aws sts get-caller-identity --query "Arn" --output text)
        echo "[OK] AWS Authentication successful: $IDENTITY"
    else
        echo "[ERROR] AWS Authentication failed. Please run 'aws configure' or check your AWS profile/credentials."
        FAILED=1
    fi
else
    echo "[ERROR] Cannot validate AWS Authentication without AWS CLI."
    FAILED=1
fi

if [ $FAILED -ne 0 ]; then
    echo "[FAIL] Validation failed. Please address the errors above before running bootstrap/bootstrap.sh"
    exit 1
else
    echo "[PASS] Validation succeeded. All prerequisites met."
    exit 0
fi
