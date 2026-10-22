# -------------------------
# RDS PostgreSQL
# -------------------------

resource "aws_db_subnet_group" "cloudlaunch" {
  name = "${var.project_name}-db-subnet-group"

  subnet_ids = [
    aws_subnet.private_1.id,
    aws_subnet.private_2.id
  ]

  tags = {
    Name    = "${var.project_name}-db-subnet-group"
    Project = var.project_name
  }
}

resource "random_password" "database" {
  length           = 24
  special          = true
  override_special = "!#$%&*()-_=+[]{}"
}

resource "aws_db_instance" "postgres" {
  identifier = "${var.project_name}-postgres"

  engine         = "postgres"
  instance_class = "db.t4g.micro"

  allocated_storage     = 20
  max_allocated_storage = 30
  storage_type          = "gp3"

  db_name  = "cloudlaunch"
  username = "cloudlaunchadmin"
  password = random_password.database.result

  db_subnet_group_name   = aws_db_subnet_group.cloudlaunch.name
  vpc_security_group_ids = [aws_security_group.rds.id]

  publicly_accessible = false
  multi_az            = false
  skip_final_snapshot = true
  deletion_protection = false

  backup_retention_period = 1

  tags = {
    Name    = "${var.project_name}-postgres"
    Project = var.project_name
  }
}
