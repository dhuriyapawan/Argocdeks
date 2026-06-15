# modules/redis/main.tf

resource "aws_elasticache_replication_group" "redis" {
  replication_group_id          = "${var.environment}-redis"
  description                   = "Redis replication group for RideShareX ${var.environment}"
  node_type                     = var.node_type
  num_cache_clusters            = var.num_cache_clusters
  port                          = 6379
  parameter_group_name          = "default.redis7"
  subnet_group_name             = aws_elasticache_subnet_group.redis.name
  security_group_ids            = [var.security_group_id]
  at_rest_encryption_enabled    = true
  transit_encryption_enabled   = true
  auth_token                    = var.auth_token
  kms_key_id                    = var.kms_key_arn

  tags = var.tags
}
