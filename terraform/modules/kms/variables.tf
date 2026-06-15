# modules/kms/variables.tf

variable "environment" {
  type        = string
  description = "Target environment"
}

variable "account_id" {
  type        = string
  description = "AWS Account ID"
}

variable "deletion_window_in_days" {
  type        = number
  description = "KMS key deletion window"
  default     = 30
}

variable "tags" {
  type        = map(string)
  default     = {}
}
