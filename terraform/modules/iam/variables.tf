# modules/iam/variables.tf

variable "environment" {
  type        = string
  description = "Target environment"
}

# variable "oidc_provider_arn" {
#   type        = string
#   description = "EKS Cluster OIDC Provider ARN (required for IRSA)"
#   default     = ""
# }

# variable "oidc_provider_url" {
#   type        = string
#   description = "EKS Cluster OIDC Provider URL (required for IRSA)"
#   default     = ""
# }

variable "tags" {
  type        = map(string)
  default     = {}
}
