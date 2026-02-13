locals {
  base_tags = merge(var.tags, {
    module = "db"
  })
}

resource "aws_security_group" "db" {
  name        = "${var.name}-db-sg"
  description = "Database access security group"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr_blocks
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.base_tags, {
    Name = "${var.name}-db-sg"
  })
}

resource "aws_db_subnet_group" "this" {
  name       = "${var.name}-db-subnet-group"
  subnet_ids = var.subnet_ids

  tags = merge(local.base_tags, {
    Name = "${var.name}-db-subnet-group"
  })
}

resource "aws_db_instance" "this" {
  identifier                     = "${var.name}-postgres"
  engine                         = "postgres"
  engine_version                 = var.engine_version
  db_name                        = var.db_name
  username                       = var.username
  instance_class                 = var.instance_class
  allocated_storage              = var.allocated_storage
  storage_encrypted              = true
  manage_master_user_password    = true
  multi_az                       = var.multi_az
  publicly_accessible            = false
  vpc_security_group_ids         = [aws_security_group.db.id]
  db_subnet_group_name           = aws_db_subnet_group.this.name
  backup_retention_period        = var.backup_retention_days
  deletion_protection            = var.deletion_protection
  skip_final_snapshot            = false
  final_snapshot_identifier      = "${var.name}-final-snapshot"
  performance_insights_enabled   = true
  auto_minor_version_upgrade     = true
  apply_immediately              = false
  iam_database_authentication_enabled = true

  tags = merge(local.base_tags, {
    Name = "${var.name}-postgres"
  })
}
