# Microservice Application Deployment Files

This directory contains raw Kubernetes manifests for manual service testing.

## Deployment Strategy
- **Production/Staging**: Services are packaged as Helm charts (`/helm`) and deployed continuously via ArgoCD (`/argocd`).
- **Raw Manifests**: A reference example for raw deployment and service manifests is provided under `ride-service/`.
