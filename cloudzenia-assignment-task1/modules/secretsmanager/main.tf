resource "aws_secretsmanager_secret" "cred_store" {
  name = "${var.project_name}-db-credentials"
}

resource "aws_secretsmanager_secret_version" "secret_version" {
  secret_id     = aws_secretsmanager_secret.cred_store.id
  secret_string = jsonencode({ # Use jsonencode to create a JSON string
    username = var.db_username
    password = var.db_password
  })
}

