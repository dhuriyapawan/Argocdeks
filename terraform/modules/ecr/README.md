# ECR Terraform Module

This module sets up:
- AWS ECR Repositories for frontend and backend microservices
- Lifecycle policies to automatically rotate and clean old images (keeps latest 30)
- Image scanning on push enabled
- KMS server-side encryption enabled
