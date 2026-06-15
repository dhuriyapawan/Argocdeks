# modules/route53/variables.tf

variable "environment" {
  type        = string
  description = "Target environment"
}

variable "domain_name" {
  type        = string
  description = "Primary domain name for the hosted zone"
}

variable "subdomain" {
  type        = string
  description = "Subdomain to use (optional)"
  default     = ""
}

variable "alb_dns_name" {
  type        = string
  description = "ALB DNS name to route to"
}

variable "alb_zone_id" {
  type        = string
  description = "ALB hosted zone ID"
}

variable "tags" {
  type        = map(string)
  default     = {}
}
