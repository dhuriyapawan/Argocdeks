# modules/rds/variables.tf

variable "environment" {
  type        = string
  description = "Target environment"
}

variable "allocated_storage" {
  type        = number
  default     = 20
}

variable "max_allocated_storage" {
  type        = number
  default     = 100
}

variable "engine_version" {
  type        = string
  default     = "15.4"
}

variable "instance_class" {
  type        = string
  default     = "db.t3.micro"
}

variable "db_name" {
  type        = string
  default     = "rideshare"
}

variable "username" {
  type        = string
  default     = "dbadmin"
}

variable "password" {
  type        = string
  description = "Database administrator password"
  sensitive   = true
}

variable "database_subnet_ids" {
  type        = list(string)
  description = "Subnets to use for the database"
}

variable "security_group_id" {
  type        = string
  description = "Security group for the database"
}

variable "kms_key_arn" {
  type        = string
  description = "KMS Key ARN for DB encryption"
}

variable "multi_az" {
  type        = bool
  default     = false
}

variable "skip_final_snapshot" {
  type        = bool
  default     = true
}

variable "backup_retention_period" {
  type        = number
  default     = 7
}

variable "deletion_protection" {
  type        = bool
  default     = false
}

variable "tags" {
  type        = map(string)
  default     = {}
}
variable "create_db_subnet_group" {
  type    = bool
  default = true
}