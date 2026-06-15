# modules/ecr/variables.tf

variable "environment" {
  type        = string
  description = "Target environment"
}

variable "tags" {
  type        = map(string)
  default     = {}
}
