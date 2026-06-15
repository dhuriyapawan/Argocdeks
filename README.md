# RideShareX

RideShareX is a production-grade, microservice-based ridesharing platform. It utilizes AWS, Terraform, Kubernetes (EKS), Helm, ArgoCD (GitOps), and comprehensive observability tools (Prometheus, Grafana, Loki) to deploy and maintain high-availability services.

## Repository Structure

- `bootstrap/`: Setup/teardown tools and validating environments.
- `terraform/`: Infrastructure as Code (IaC) using modular design for VPC, EKS, RDS, Redis, Route53, ALB, and IAM.
- `kubernetes/`: Declared namespaces, ingresses, logging, monitoring, and autoscaling config.
- `helm/`: Kubernetes templates packaged as Helm charts for all services.
- `argocd/`: GitOps definitions (App-of-Apps pattern) to synchronize clusters.
- `applications/`: Source code, package files, and Dockerfiles for frontend and backend microservices.
- `observability/`: Global Prometheus, Grafana, and Loki configs.
- `scripts/`: Deployment, rollback, and database management utilities.
- `docs/`: Technical specifications, architecture designs, and operations guides.
- `.github/`: Automations via GitHub Actions.

## Getting Started

1. **Bootstrap local tools**: Run `./bootstrap/install-tools.sh` to get required CLI tools (AWS CLI, terraform, kubectl, helm).
2. **Initialize Infrastructure**: Configure environment parameters in `terraform/environments/dev/terraform.tfvars`, then run `./bootstrap/bootstrap.sh`.
3. **Deploy Applications**: Deploy through GitOps by pointing ArgoCD to this repository using the root app configuration in `argocd/app-of-apps/root-app.yaml`.
