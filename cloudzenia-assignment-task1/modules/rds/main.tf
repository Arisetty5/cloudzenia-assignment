

resource "aws_db_subnet_group" "db_sb_grp" {
  name       = "${var.project_name}-db-subnet-group"
  subnet_ids = var.private_subnet_ids
  tags       = var.tags
}

resource "aws_db_instance" "db-instance" {
  identifier             = "${var.project_name}-wordpress-db"
  allocated_storage      = 20
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t3.micro"     # Free tier eligible
  db_name                = var.db_name
  username               = var.db_username
  password               = var.db_password
  db_subnet_group_name   = aws_db_subnet_group.db_sb_grp.name
  vpc_security_group_ids = var.db_security_group_ids
  skip_final_snapshot    = true
  backup_retention_period = 7                # 7 days backup
  multi_az               = false
  publicly_accessible    = false             # PRIVATE database
  tags                   = var.tags
}
