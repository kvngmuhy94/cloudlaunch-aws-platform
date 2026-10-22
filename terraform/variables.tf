variable "project_name" {
  description = "Project name used for AWS resources"
  type        = string
  default     = "cloudlaunch"
}

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "eu-west-2"
}
