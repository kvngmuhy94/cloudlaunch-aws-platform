# -------------------------
# Elastic Container Registry
# -------------------------

resource "aws_ecr_repository" "cloudlaunch" {
  name                 = var.project_name
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name    = "${var.project_name}-ecr"
    Project = var.project_name
  }
}

resource "aws_ecr_lifecycle_policy" "cloudlaunch" {
  repository = aws_ecr_repository.cloudlaunch.name

  policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Keep only the 5 most recent images"

        selection = {
          tagStatus   = "any"
          countType   = "imageCountMoreThan"
          countNumber = 5
        }

        action = {
          type = "expire"
        }
      }
    ]
  })
}
