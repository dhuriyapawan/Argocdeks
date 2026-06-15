# modules/alb/variables.tf

variable "vpc_id" {
  type        = string
  description = "The ID of the VPC"
}

variable "environment" {
  type        = string
  description = "Target environment"
}

variable "public_subnet_ids" {
  type        = list(string)
  description = "List of public subnet IDs"
}

variable "security_group_id" {
  type        = string
  description = "Security group ID for the ALB"
}

variable "enable_deletion_protection" {
  type        = bool
  default     = false
}

variable "enable_https" {
  type        = bool
  default     = false
}

variable "certificate_arn" {
  type        = string
  description = "ACM Certificate ARN for HTTPS listener"
  default     = ""
}

variable "tags" {
  type        = map(string)
  default     = {}
}
