# modules/security-groups/variables.tf

variable "vpc_id" {
  type        = string
  description = "The ID of the VPC"
}

variable "environment" {
  type        = string
  description = "Target environment"
}

variable "tags" {
  type        = map(string)
  default     = {}
}
