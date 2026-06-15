# modules/eks/variables.tf

variable "environment" {
  type        = string
  description = "Target environment"
}

variable "cluster_version" {
  type        = string
  description = "Kubernetes Version for EKS"
  default     = "1.29"
}

variable "cluster_role_arn" {
  type        = string
  description = "IAM Role ARN for the EKS control plane"
}

variable "node_role_arn" {
  type        = string
  description = "IAM Role ARN for the EKS worker nodes"
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "List of private subnet IDs for EKS worker nodes"
}

variable "cluster_security_group_id" {
  type        = string
  description = "Security group ID for the EKS cluster control plane"
}

variable "kms_key_arn" {
  type        = string
  description = "KMS Key ARN for secrets encryption"
}

variable "cluster_role_dependency" {
  type        = any
  description = "Dependency on EKS cluster role attachment"
}

# Scaling Variables
variable "system_node_desired_size" {
  type    = number
  default = 2
}

variable "system_node_max_size" {
  type    = number
  default = 3
}

variable "system_node_min_size" {
  type    = number
  default = 1
}

variable "app_node_desired_size" {
  type    = number
  default = 2
}

variable "app_node_max_size" {
  type    = number
  default = 5
}

variable "app_node_min_size" {
  type    = number
  default = 1
}

variable "tags" {
  type        = map(string)
  default     = {}
}
