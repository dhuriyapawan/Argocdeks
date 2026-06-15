# terraform/environments/prod/variables.tf

variable "aws_region" {
  type        = string
  description = "AWS Region to deploy resource"
  default     = "us-east-1"
}

variable "vpc_cidr" {
  type        = string
  description = "The CIDR block for the VPC"
  default     = "10.20.0.0/16"
}

variable "public_subnet_cidrs" {
  type    = list(string)
  default = ["10.20.1.0/24", "10.20.2.0/24", "10.20.3.0/24"]
}

variable "private_subnet_cidrs" {
  type    = list(string)
  default = ["10.20.10.0/24", "10.20.11.0/24", "10.20.12.0/24"]
}

variable "database_subnet_cidrs" {
  type    = list(string)
  default = ["10.20.20.0/24", "10.20.21.0/24", "10.20.22.0/24"]
}

variable "availability_zones" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "cluster_version" {
  type    = string
  default = "1.29"
}

variable "db_password" {
  type        = string
  description = "Master password for PostgreSQL database"
  sensitive   = true
}

variable "redis_auth_token" {
  type        = string
  description = "Authentication token for Redis cache cluster"
  sensitive   = true
}

variable "domain_name" {
  type        = string
  description = "Main domain name for Route53 mapping"
}

variable "certificate_arn" {
  type        = string
  description = "Production SSL Certificate ARN from ACM"
}
