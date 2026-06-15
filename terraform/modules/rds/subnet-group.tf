# modules/rds/subnet-group.tf

resource "aws_db_subnet_group" "db_subnets" {
  name        = "${var.environment}-rds-subnet-group"
  description = "Database subnet group for ${var.environment}"
  subnet_ids  = var.database_subnet_ids

  tags = var.tags
}
