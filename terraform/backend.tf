# terraform/backend.tf
# Backend declaration is typically set in individual environment folders.
# This file serves as documentation for the S3 + DynamoDB state locking backend structure.

terraform {
  backend "s3" {
    bucket         = "ridesharex-tfstate-bucket"
    key            = "global/s3/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "ridesharex-tflocks"
    encrypt        = true
  }
}
