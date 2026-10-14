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

