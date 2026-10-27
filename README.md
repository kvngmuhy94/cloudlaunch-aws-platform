# CloudLaunch

CloudLaunch is a cloud and DevOps portfolio project demonstrating how a containerised FastAPI application can be deployed with PostgreSQL locally and later migrated to AWS ECS Fargate and Amazon RDS.

## Current Architecture

FastAPI
   |
   v
Docker
   |
   v
Docker Compose
   |
   +--> CloudLaunch API
   |
   +--> PostgreSQL
           |
           v
      Persistent Volume

## Current Features

- FastAPI REST API
- Docker containerisation
- PostgreSQL database
- SQLAlchemy ORM
- Docker Compose
- Persistent PostgreSQL storage
- Health endpoint
- Readiness endpoint
- Create and retrieve API items

## Endpoints

- `/`
- `/health`
- `/ready`
- `/api/items`

## Local Start

```bash
docker compose up -d --build


## AWS Cloud Infrastructure

CloudLaunch is deployed on AWS using infrastructure managed with Terraform.

### AWS Services
- Amazon ECS with AWS Fargate for container orchestration
- Amazon ECR for container image storage
- Application Load Balancer for HTTP traffic
- Amazon RDS PostgreSQL for database hosting
- AWS Secrets Manager for sensitive configuration
- Amazon CloudWatch for metrics, dashboards and alarms
- Amazon SNS for email notifications
- Amazon VPC with public and private subnets

## Monitoring and Observability

A CloudWatch dashboard named `CloudLaunch-Operations` provides visibility into:

- ECS CPU utilisation
- ECS memory utilisation
- Application request count
- Application response time
- RDS CPU utilisation
- RDS database connections
- CloudWatch alarm status

### CloudWatch Alarms

Three monitoring alarms have been configured:

| Alarm | Purpose |
|---|---|
| CloudLaunch-High-CPU | Detect excessive CPU utilisation |
| CloudLaunch-No-Healthy-Targets | Detect unhealthy load balancer targets |
| CloudLaunch-No-Running-Tasks | Detect when no ECS tasks are running |

## Incident Simulation and Recovery

An ECS service outage was deliberately simulated to validate monitoring and alerting.

### Test Procedure

1. Reduced the ECS service desired task count to zero.
2. Confirmed that the ECS service had no running tasks.
3. Verified that CloudWatch detected the outage.
4. Confirmed that the No-Running-Tasks alarm entered ALARM state.
5. Received an automated email notification through Amazon SNS.
6. Restored the ECS service desired task count to one.
7. Waited for the ECS service to become stable.
8. Verified that the CloudWatch alarm returned to OK.

### Test Outcome

The incident simulation successfully demonstrated automated failure detection, email alerting, manual service recovery and monitoring verification.

## Operational Skills Demonstrated

- Infrastructure as Code using Terraform
- AWS container deployment and management
- CloudWatch monitoring and observability
- Incident detection and troubleshooting
- SNS email alerting
- ECS service recovery
- AWS CLI operations
- Git and GitHub version control

