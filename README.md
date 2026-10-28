# Docker Voting App — DevOps Capstone

A containerized voting application deployed locally using Docker Compose. This project explores multi-container orchestration, service dependencies, health checks, container networking, and persistent database storage.

This project is based on the [Docker Samples Example Voting App](https://github.com/dockersamples/example-voting-app). The original application and its components belong to their respective contributors.

## Architecture

The application consists of five main services:

| Service | Technology | Responsibility |
|---|---|---|
| Vote | Python | Accepts votes through the web interface |
| Result | Node.js | Displays voting results |
| Worker | .NET | Processes votes and transfers them between services |
| Redis | Redis | Temporarily stores votes |
| Database | PostgreSQL 15 Alpine | Stores voting results persistently |

### Request and data flow

1. A user submits a vote through the Vote web application.
2. Redis temporarily stores the submitted vote.
3. The Worker processes votes from Redis and records them in PostgreSQL.
4. The Result application reads the stored results and displays them to the user.

## Prerequisites

- Docker Engine
- Docker Compose
- Git
- A terminal with access to the Docker daemon

## Run locally

Clone your repository and enter the project directory:

```bash
git clone https://github.com/Mclina/example-voting-app.git
cd example-voting-app
```

Build the application images and start the services:

```bash
sudo docker compose up -d --build
```

Check service status:

```bash
sudo docker compose ps
```

View application logs:

```bash
sudo docker compose logs --tail=50
```

## Access the application

- **Voting interface:** http://localhost:8080
- **Results interface:** http://localhost:8081

Submit a vote through the voting interface, then visit the results page to verify that the result appears.

## Health checks and networking

Docker Compose defines health checks for the Vote, Redis, and PostgreSQL services. The Result service waits for PostgreSQL to become healthy, while the Worker waits for both Redis and PostgreSQL to become healthy.

The application uses two Docker networks:

- `front-tier` connects the web-facing Vote and Result services.
- `back-tier` connects the application services to the supporting data services.

PostgreSQL data is stored in the named Docker volume `db-data`, allowing database files to persist when the database container is recreated.

## Troubleshooting

Check service status:

```bash
sudo docker compose ps
```

Inspect database logs:

```bash
sudo docker compose logs --tail=80 db
```

Inspect the Worker logs:

```bash
sudo docker compose logs --tail=50 worker
```

Inspect the health status of the database:

```bash
sudo docker inspect example-voting-app-db-1 \
  --format '{{json .State.Health}}'
```

If a dependency is initially unhealthy, inspect its logs and health status before attempting a restart or changing persistent data.

## Stop the application

Stop the services without intentionally removing the named database volume:

```bash
sudo docker compose down
```

To start them again:

```bash
sudo docker compose up -d
```

## Skills demonstrated

- Docker image builds and multi-container deployments
- Docker Compose orchestration
- Container networking and service discovery
- Health checks and dependency management
- Redis and PostgreSQL integration
- Persistent volumes
- Application log inspection and troubleshooting
- End-to-end functional verification

## Future improvements

- Add a GitHub Actions CI pipeline.
- Add automated tests and image vulnerability scanning.
- Improve monitoring and observability.
- Evaluate deployment to Kubernetes.
- Document architecture and deployment decisions.

## Attribution

This project is derived from the [Docker Samples Example Voting App](https://github.com/dockersamples/example-voting-app). Refer to the original repository and its license for attribution and licensing details.

