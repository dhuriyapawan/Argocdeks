# modules/vpc/variables.tf

variable "vpc_cidr" {
  type        = string
  description = "The CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "environment" {
  type        = string
  description = "Target environment (e.g. dev, prod)"
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "List of public subnet CIDR blocks"
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "List of private subnet CIDR blocks"
}

variable "database_subnet_cidrs" {
  type        = list(string)
  description = "List of database subnet CIDR blocks"
}

variable "availability_zones" {
  type        = list(string)
  description = "List of availability zones to use"
}

variable "single_nat_gateway" {
  type        = bool
  description = "Whether to use a single NAT Gateway to reduce costs"
  default     = true
}

variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to resources"
  default     = {}
}
