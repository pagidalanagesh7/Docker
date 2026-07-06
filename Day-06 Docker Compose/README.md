# 🐳 Docker Learning Series - Day 6

# Docker Compose

> Learn how to manage multi-container applications using Docker Compose.

------------------------------------------------------------------------

# 📖 What is Docker Compose?

Docker Compose is a tool used to define and manage **multi-container
Docker applications** using a single `docker-compose.yml` file.

Instead of running multiple `docker run` commands manually, Docker
Compose lets you deploy an entire application stack with one command.

``` bash
docker compose up
```

------------------------------------------------------------------------

# Why Docker Compose?

Modern applications usually contain multiple services:

``` text
Browser
   │
   ▼
Frontend (Nginx)
   │
   ▼
Backend API
   │
   ▼
MySQL Database
   │
   ▼
Redis Cache
```

Without Compose you must manually create:

-   Containers
-   Networks
-   Volumes
-   Environment Variables
-   Port mappings

Docker Compose automates everything.

------------------------------------------------------------------------

# Key Components

## docker-compose.yml

The central configuration file describing:

-   Services
-   Images
-   Ports
-   Volumes
-   Networks
-   Environment Variables
-   Dependencies

Example:

``` yaml
version: "3.9"

services:
  web:
    image: nginx
    ports:
      - "80:80"
```

------------------------------------------------------------------------

## Services

Each service represents one container.

``` yaml
services:
  frontend:
    image: nginx

  backend:
    image: node:20

  database:
    image: mysql:8
```

------------------------------------------------------------------------

## Networks

Compose automatically creates an isolated network.

Containers communicate using service names.

Example:

    backend ----> database:3306

instead of an IP address.

------------------------------------------------------------------------

## Volumes

Volumes provide persistent storage.

``` yaml
services:
  mysql:
    image: mysql:8
    volumes:
      - mysql-data:/var/lib/mysql

volumes:
  mysql-data:
```

------------------------------------------------------------------------

## Bind Mount

``` yaml
volumes:
  - ./:/app
```

Useful during development because local code changes instantly reflect
inside the container.

------------------------------------------------------------------------

## Environment Variables

``` yaml
environment:
  MYSQL_ROOT_PASSWORD: root123
  MYSQL_DATABASE: appdb
```

Using `.env`

    MYSQL_PASSWORD=root123
    MYSQL_DATABASE=appdb

``` yaml
environment:
  MYSQL_ROOT_PASSWORD: ${MYSQL_PASSWORD}
```

------------------------------------------------------------------------

## depends_on

``` yaml
backend:
  depends_on:
    - database
```

> Note: `depends_on` controls startup order only. It does not wait for
> the database to become ready.

------------------------------------------------------------------------

## Scaling

``` bash
docker compose up --scale backend=3
```

Creates:

    backend-1
    backend-2
    backend-3

------------------------------------------------------------------------

# Common Commands

``` bash
docker compose up
docker compose up -d
docker compose down
docker compose restart
docker compose ps
docker compose logs
docker compose logs -f
docker compose exec backend bash
docker compose build
docker compose pull
docker compose config
```

------------------------------------------------------------------------

# Real-Time Project Example

An Online Shopping application:

    Internet
       │
    Nginx
       │
    Node.js API
       │
    MySQL
       │
    Redis

Compose automatically:

-   Creates containers
-   Creates a network
-   Mounts volumes
-   Injects environment variables
-   Starts all services

Command:

``` bash
docker compose up -d
```

------------------------------------------------------------------------

# Sample Output

## docker compose ps

``` text
NAME                 STATUS      PORTS
frontend             Up          80/tcp
backend              Up          3000/tcp
mysql                Up          3306/tcp
redis                Up          6379/tcp
```

## docker compose logs

``` text
backend  | Connected to MySQL
backend  | Listening on port 3000
mysql    | Ready for connections
nginx    | Started successfully
```

------------------------------------------------------------------------

# Common Errors

## Port already allocated

    ERROR: Port is already allocated

Fix:

``` bash
docker ps
docker stop <container-id>
```

------------------------------------------------------------------------

## Connection refused

Reason:

Database isn't ready.

Fix:

-   Use healthchecks
-   Retry connection
-   Don't rely only on depends_on

------------------------------------------------------------------------

## No such service

``` bash
docker compose config
```

Verify service names.

------------------------------------------------------------------------

# Production Best Practices

-   Use `.env`
-   Never hardcode secrets
-   Use named volumes
-   Add health checks
-   Use restart policies
-   Pin image versions
-   Use Git
-   Separate development and production Compose files

------------------------------------------------------------------------

# Top 15 Interview Questions & Answers

## 1. What is Docker Compose?

A tool for defining and managing multi-container Docker applications
using YAML.

## 2. Difference between Docker and Docker Compose?

Docker manages single containers, while Compose manages complete
multi-container applications.

## 3. What is a service?

A service defines how one container should run.

## 4. What is docker-compose.yml?

The configuration file that defines the entire application stack.

## 5. What happens during `docker compose up`?

Reads YAML → Creates network → Creates volumes → Pulls/builds images →
Starts containers.

## 6. What is depends_on?

Controls startup order only.

## 7. How do containers communicate?

Using service names through the Compose network.

## 8. Volume vs Bind Mount?

Volumes are Docker-managed and persistent. Bind mounts map host
directories.

## 9. Purpose of .env?

Keeps configuration outside the Compose file.

## 10. How do you scale services?

``` bash
docker compose up --scale backend=3
```

## 11. Difference between up and start?

`up` creates (if needed) and starts containers. `start` only starts
existing stopped containers.

## 12. Difference between stop and down?

`stop` stops containers. `down` removes containers and networks.

## 13. How do you debug Compose applications?

Use:

``` bash
docker compose ps
docker compose logs
docker compose exec
docker compose config
```

## 14. What are health checks?

Health checks verify a container is actually ready to serve requests.

## 15. What are Compose best practices?

-   Use .env
-   Use named volumes
-   Avoid latest tag
-   Use meaningful service names
-   Add health checks
-   Version control Compose files

------------------------------------------------------------------------

# Summary

You learned:

-   Docker Compose fundamentals
-   docker-compose.yml
-   Services
-   Networks
-   Volumes
-   Environment Variables
-   .env files
-   depends_on
-   Scaling
-   Commands
-   Real-world architecture
-   Production best practices
-   Troubleshooting
-   Top Interview Questions

Docker Compose is an essential DevOps tool for building, running, and
managing multi-container applications consistently across development,
testing, and production environments.
