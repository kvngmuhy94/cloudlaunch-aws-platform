resource "aws_cloudwatch_dashboard" "cloudlaunch" {
  dashboard_name = "CloudLaunch-Operations"

  dashboard_body = jsonencode({
    widgets = [
      {
        type   = "metric"
        x      = 0
        y      = 0
        width  = 12
        height = 6
        properties = {
          title  = "ECS CPU Utilization"
          region = "eu-west-2"
          metrics = [
            ["AWS/ECS", "CPUUtilization",
              "ClusterName", aws_ecs_cluster.main.name,
            "ServiceName", aws_ecs_service.cloudlaunch.name]
          ]
          period = 60
          stat   = "Average"
          view   = "timeSeries"
        }
      },
      {
        type   = "metric"
        x      = 12
        y      = 0
        width  = 12
        height = 6
        properties = {
          title  = "ECS Memory Utilization"
          region = "eu-west-2"
          metrics = [
            ["AWS/ECS", "MemoryUtilization",
              "ClusterName", aws_ecs_cluster.main.name,
            "ServiceName", aws_ecs_service.cloudlaunch.name]
          ]
          period = 60
          stat   = "Average"
          view   = "timeSeries"
        }
      },
      {
        type   = "metric"
        x      = 0
        y      = 6
        width  = 12
        height = 6
        properties = {
          title  = "ALB Request Count"
          region = "eu-west-2"
          metrics = [
            ["AWS/ApplicationELB", "RequestCount",
            "LoadBalancer", aws_lb.cloudlaunch.arn_suffix]
          ]
          period = 60
          stat   = "Sum"
          view   = "timeSeries"
        }
      },
      {
        type   = "metric"
        x      = 12
        y      = 6
        width  = 12
        height = 6
        properties = {
          title  = "Application Response Time"
          region = "eu-west-2"
          metrics = [
            ["AWS/ApplicationELB", "TargetResponseTime",
            "LoadBalancer", aws_lb.cloudlaunch.arn_suffix]
          ]
          period = 60
          stat   = "Average"
          view   = "timeSeries"
        }
      },
      {
        type   = "metric"
        x      = 0
        y      = 12
        width  = 12
        height = 6
        properties = {
          title  = "RDS CPU Utilization"
          region = "eu-west-2"
          metrics = [
            ["AWS/RDS", "CPUUtilization",
            "DBInstanceIdentifier", aws_db_instance.postgres.identifier]
          ]
          period = 60
          stat   = "Average"
          view   = "timeSeries"
        }
      },
      {
        type   = "metric"
        x      = 12
        y      = 12
        width  = 12
        height = 6
        properties = {
          title  = "RDS Database Connections"
          region = "eu-west-2"
          metrics = [
            ["AWS/RDS", "DatabaseConnections",
            "DBInstanceIdentifier", aws_db_instance.postgres.identifier]
          ]
          period = 60
          stat   = "Average"
          view   = "timeSeries"
        }
      },
      {
        type   = "alarm"
        x      = 0
        y      = 18
        width  = 24
        height = 6
        properties = {
          title = "CloudLaunch Alarm Status"
          alarms = [
            aws_cloudwatch_metric_alarm.high_cpu.arn,
            aws_cloudwatch_metric_alarm.no_healthy_targets.arn,
            aws_cloudwatch_metric_alarm.no_running_tasks.arn
          ]
        }
      }
    ]
  })
}
