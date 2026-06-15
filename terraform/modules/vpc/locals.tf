# modules/vpc/locals.tf

locals {
  # Define standard naming suffixes or VPC metrics
  vpc_name = "${var.environment}-vpc"
}
