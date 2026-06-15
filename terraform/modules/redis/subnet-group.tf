# modules/redis/subnet-group.tf

resource "aws_elasticache_subnet_group" "redis" {
  name        = "${var.environment}-redis-subnet-group"
  subnet_ids  = var.database_subnet_ids
  description = "Subnet group for Redis ${var.environment}"
}
