# modules/redis/variables.tf

variable "environment" {
  type        = string
  description = "Target environment"
}

variable "node_type" {
  type    = string
  default = "cache.t3.micro"
}

variable "num_cache_clusters" {
  type    = number
  default = 1
}

variable "database_subnet_ids" {
  type        = list(string)
  description = "Subnets to use for the cluster"
}

variable "security_group_id" {
  type        = string
  description = "Security group for the cluster"
}

variable "auth_token" {
  type        = string
  description = "Auth token for Redis client validation"
  sensitive   = true
}

variable "kms_key_arn" {
  type        = string
  description = "KMS Key ARN for Redis encryption"
}

variable "tags" {
  type        = map(string)
  default     = {}
}
