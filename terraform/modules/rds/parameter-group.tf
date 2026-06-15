# modules/rds/parameter-group.tf

resource "aws_db_parameter_group" "pg" {
  name   = "${var.environment}-postgres15-pg"
  family = "postgres15"

  parameter {
    name  = "rds.force_ssl"
    value = "1"
  }

  tags = var.tags
}
