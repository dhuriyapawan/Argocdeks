# modules/redis/outputs.tf

output "redis_primary_endpoint" {
  description = "The address of the primary endpoint for Redis replication group"
  value       = aws_elasticache_replication_group.redis.primary_endpoint_address
}

output "redis_reader_endpoint_address" {
  description = "The address of the reader endpoint for Redis replication group"
  value       = aws_elasticache_replication_group.redis.reader_endpoint_address
}

output "redis_port" {
  description = "Redis port"
  value       = 6379
}
