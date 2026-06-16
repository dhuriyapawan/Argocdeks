# modules/rds/subnet-group.tf

resource "aws_db_subnet_group" "db_subnets" {
  count       = var.create_db_subnet_group ? 1 : 0 
  name        = "${var.environment}-rds-subnet-group"
  description = "Database subnet group for ${var.environment}"
  subnet_ids  = var.database_subnet_ids

  tags = var.tags
}
