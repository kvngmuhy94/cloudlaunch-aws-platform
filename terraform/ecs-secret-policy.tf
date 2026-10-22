resource "aws_iam_role_policy" "ecs_secret_access" {
  name = "${var.project_name}-secret-access"
  role = aws_iam_role.ecs_task_execution.id

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Action = [
          "secretsmanager:GetSecretValue"
        ]

        Resource = aws_secretsmanager_secret.database_url.arn
      }
    ]
  })
}
