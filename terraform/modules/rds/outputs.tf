# modules/rds/outputs.tf

output "db_instance_endpoint" {
  description = "The connection endpoint for RDS Postgres"
  value       = aws_db_instance.postgres.endpoint
}

output "db_instance_address" {
  description = "The hostname of the RDS instance"
  value       = aws_db_instance.postgres.address
}

output "db_instance_username" {
  description = "The master username for the database"
  value       = aws_db_instance.postgres.username
}

output "db_instance_port" {
  description = "The database port"
  value       = aws_db_instance.postgres.port
}
