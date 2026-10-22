output "aws_region" {
  value = var.aws_region
}

output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_ids" {
  value = [
    aws_subnet.public_1.id,
    aws_subnet.public_2.id
  ]
}

output "private_subnet_ids" {
  value = [
    aws_subnet.private_1.id,
    aws_subnet.private_2.id
  ]
}

output "ecr_repository_url" {
  value = aws_ecr_repository.cloudlaunch.repository_url
}

output "ecs_cluster_name" {
  value = aws_ecs_cluster.main.name
}

output "alb_security_group_id" {
  value = aws_security_group.alb.id
}

output "ecs_security_group_id" {
  value = aws_security_group.ecs.id
}

output "rds_security_group_id" {
  value = aws_security_group.rds.id
}

output "ecs_task_definition_arn" {
  value = aws_ecs_task_definition.cloudlaunch.arn
}

output "ecs_task_execution_role_arn" {
  value = aws_iam_role.ecs_task_execution.arn
}

output "cloudwatch_log_group" {
  value = aws_cloudwatch_log_group.cloudlaunch.name
}

output "rds_endpoint" {
  value = aws_db_instance.postgres.address
}

output "database_secret_arn" {
  value = aws_secretsmanager_secret.database_url.arn
}

output "load_balancer_dns" {
  value = aws_lb.cloudlaunch.dns_name
}

output "cloudlaunch_url" {
  value = "http://${aws_lb.cloudlaunch.dns_name}"
}

output "ecs_service_name" {
  value = aws_ecs_service.cloudlaunch.name
}
