# terraform/environments/dev/backend.tf

terraform {
  # For ease of testing/local run without AWS pre-requisites, we default to local backend.
  # In production, replace this with the commented S3 backend below.
  backend "local" {
    path = "terraform.tfstate"
  }

  # backend "s3" {
  #   bucket         = "ridesharex-tfstate-dev"
  #   key            = "dev/terraform.tfstate"
  #   region         = "us-east-1"
  #   dynamodb_table = "ridesharex-locks-dev"
  #   encrypt        = true
  # }
}
 