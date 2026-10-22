# -------------------------
# Secrets Manager
# -------------------------

resource "aws_secretsmanager_secret" "database_url" {
  name = "${var.project_name}/database-url"

  tags = {
    Project = var.project_name
  }
}

resource "aws_secretsmanager_secret_version" "database_url" {
  secret_id = aws_secretsmanager_secret.database_url.id

  secret_string = "postgresql+psycopg://${aws_db_instance.postgres.username}:${urlencode(random_password.database.result)}@${aws_db_instance.postgres.address}:5432/${aws_db_instance.postgres.db_name}"
}
