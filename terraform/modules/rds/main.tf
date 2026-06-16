# modules/rds/main.tf

resource "aws_db_instance" "postgres" {
  identifier                  = "${var.environment}-postgres"
  allocated_storage           = var.allocated_storage
  max_allocated_storage       = var.max_allocated_storage
  engine                      = "postgres"
  engine_version              = var.engine_version
  instance_class              = var.instance_class
  db_name                     = var.db_name
  username                    = var.username
  password                    = var.password
  port                        = 5432
  db_subnet_group_name        = aws_db_subnet_group.db_subnets[count.index]
  parameter_group_name        = aws_db_parameter_group.pg.name
  vpc_security_group_ids      = [var.security_group_id]
  storage_encrypted           = true
  kms_key_id                  = var.kms_key_arn
  multi_az                    = var.multi_az
  publicly_accessible         = false
  skip_final_snapshot         = var.skip_final_snapshot
  final_snapshot_identifier   = "${var.environment}-postgres-final-snapshot"
  backup_retention_period     = var.backup_retention_period
  deletion_protection         = var.deletion_protection

  tags = var.tags
}
