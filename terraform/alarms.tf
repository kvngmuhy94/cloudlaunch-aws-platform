data "aws_sns_topic" "cloudlaunch_alerts" {
  name = "cloudlaunch-alerts"
}

resource "aws_cloudwatch_metric_alarm" "high_cpu" {
  alarm_name          = "CloudLaunch-High-CPU"
  namespace           = "AWS/ECS"
  metric_name         = "CPUUtilization"
  statistic           = "Average"
  period              = 60
  evaluation_periods  = 5
  threshold           = 80
  comparison_operator = "GreaterThanThreshold"
  treat_missing_data  = "notBreaching"

  dimensions = {
    ClusterName = aws_ecs_cluster.main.name
    ServiceName = aws_ecs_service.cloudlaunch.name
  }

  alarm_actions = [
    data.aws_sns_topic.cloudlaunch_alerts.arn
  ]
}

resource "aws_cloudwatch_metric_alarm" "no_healthy_targets" {
  alarm_description   = "CloudLaunch has no healthy ECS targets"
  datapoints_to_alarm = 2
  alarm_name          = "CloudLaunch-No-Healthy-Targets"
  namespace           = "AWS/ApplicationELB"
  metric_name         = "HealthyHostCount"
  statistic           = "Minimum"
  period              = 60
  evaluation_periods  = 2
  threshold           = 1
  comparison_operator = "LessThanThreshold"
  treat_missing_data  = "breaching"

  dimensions = {
    LoadBalancer = aws_lb.cloudlaunch.arn_suffix
    TargetGroup  = aws_lb_target_group.cloudlaunch.arn_suffix
  }

  alarm_actions = [
    data.aws_sns_topic.cloudlaunch_alerts.arn
  ]
}

resource "aws_cloudwatch_metric_alarm" "no_running_tasks" {
  alarm_description   = "Alert when CloudLaunch ECS has no running tasks"
  alarm_name          = "CloudLaunch-No-Running-Tasks"
  namespace           = "ECS/ContainerInsights"
  metric_name         = "RunningTaskCount"
  statistic           = "Average"
  period              = 60
  evaluation_periods  = 3
  threshold           = 1
  comparison_operator = "LessThanThreshold"
  treat_missing_data  = "breaching"

  dimensions = {
    ClusterName = aws_ecs_cluster.main.name
    ServiceName = aws_ecs_service.cloudlaunch.name
  }

  alarm_actions = [
    data.aws_sns_topic.cloudlaunch_alerts.arn
  ]
}
