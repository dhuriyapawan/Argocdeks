# terraform/environments/dev/variables.tf

variable "aws_region" {
  type        = string
  description = "AWS Region to deploy resource"
  default     = "us-east-1"
}

variable "vpc_cidr" {
  type        = string
  description = "The CIDR block for the VPC"
  default     = "10.10.0.0/16"
}

variable "public_subnet_cidrs" {
  type    = list(string)
  default = ["10.10.1.0/24", "10.10.2.0/24"]
}

variable "private_subnet_cidrs" {
  type    = list(string)
  default = ["10.10.10.0/24", "10.10.11.0/24"]
}

variable "database_subnet_cidrs" {
  type    = list(string)
  default = ["10.10.20.0/24", "10.10.21.0/24"]
}

variable "availability_zones" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b"]
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
  default     = "ridesharex.local"
}
variable "db_username" {
  type    = string
  default = "postgres"
}
variable "db_name" {
  type    = string
  default = "rideshare"
}