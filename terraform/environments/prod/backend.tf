# terraform/environments/prod/backend.tf

terraform {
  # Remote state backend configuration for production.
  # Placed here as scaffolding, defaults to local state for ease of deployment testing.
  backend "local" {
    path = "terraform.tfstate"
  }

  # backend "s3" {
  #   bucket         = "ridesharex-tfstate-prod"
  #   key            = "prod/terraform.tfstate"
  #   region         = "us-east-1"
  #   dynamodb_table = "ridesharex-locks-prod"
  #   encrypt        = true
  # }
}
