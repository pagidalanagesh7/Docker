# 🐳 Docker Learning Series - Day 6

# Docker Compose

> Learn how to manage multi-container applications using Docker Compose.

---

# 📖 What is Docker Compose?

Docker Compose is a tool that allows you to define and manage **multiple Docker containers** using a single YAML configuration file (`docker-compose.yml`).

Instead of running multiple `docker run` commands manually, Docker Compose lets you start an entire application stack with a single command.

Example:

Instead of running:

```bash
docker run -d --name mysql mysql:8

docker run -d \
--name backend \
--link mysql:mysql backend-app

docker run -d \
--name frontend frontend-app
```

You simply execute:

```bash
docker compose up
```

Docker Compose creates and manages all containers automatically.

---

# Why Docker Compose?

Managing multiple containers manually becomes difficult.

Example application:

```
Frontend
     │
     ▼
Backend API
     │
     ▼
Database
```

Without Compose you need to:

- Create containers
- Create networks
- Create volumes
- Pass environment variables
- Connect containers together

Docker Compose automates all these tasks.

---

# Benefits of Docker Compose

- Single YAML configuration
- Easy to start complete application
- Easy to stop everything
- Automatic networking
- Better collaboration
- Reproducible environments
- Great for development
- Supports scaling

---

# Docker Compose Workflow

```
Write docker-compose.yml
          │
          ▼
docker compose up
          │
          ▼
Docker creates:

✔ Networks
✔ Volumes
✔ Containers
✔ Environment Variables
          │
          ▼
Application Ready
```

---

# docker-compose.yml

This is the heart of Docker Compose.

It describes:

- Services
- Images
- Ports
- Networks
- Volumes
- Environment Variables
- Dependencies

Example:

```yaml
version: "3.9"

services:

  web:
    image: nginx
    ports:
      - "80:80"
```

Run:

```bash
docker compose up
```

---

# Services

A service represents one container.

Example:

```
Frontend Service
Backend Service
Database Service
Redis Service
```

Example:

```yaml
services:

  frontend:
    image: nginx

  backend:
    image: node:20

  database:
    image: mysql:8
```

Each service becomes a container.

---

# Multi-Container Applications

Modern applications rarely consist of a single container.

Typical architecture:

```
Browser
   │
   ▼
Frontend Container
   │
   ▼
Backend Container
   │
   ▼
Database Container
```

Docker Compose manages all containers together.

---

# Example Multi-Container Application

```yaml
version: "3.9"

services:

  frontend:
    image: nginx
    ports:
      - "80:80"

  backend:
    image: node:20
    ports:
      - "3000:3000"

  database:
    image: mysql:8
```

Start everything:

```bash
docker compose up
```

---

# Networks

Docker Compose automatically creates a network.

```
Compose Network

Frontend
     │
     │
Backend
     │
     │
Database
```

Containers communicate using **service names**.

Example:

Backend connects to:

```
database:3306
```

instead of

```
192.168.x.x
```

Example:

```yaml
services:

  backend:
    image: node:20

  database:
    image: mysql:8
```

Backend can reach MySQL using:

```
database
```

---

# Custom Networks

```yaml
version: "3.9"

services:

  frontend:
    image: nginx
    networks:
      - app-network

  backend:
    image: node:20
    networks:
      - app-network

networks:

  app-network:
```

Benefits:

- Better isolation
- Secure communication
- Easy service discovery

---

# Volumes

Containers are temporary.

If a container is removed, its data is lost.

Volumes provide persistent storage.

Example:

```yaml
services:

  mysql:
    image: mysql:8

    volumes:
      - mysql-data:/var/lib/mysql

volumes:

  mysql-data:
```

Now database data survives container recreation.

---

# Bind Mount Example

```yaml
services:

  app:

    image: node:20

    volumes:
      - ./:/app
```

Changes made on your local machine are immediately reflected inside the container.

Perfect for development.

---

# Environment Variables

Environment variables help configure applications without modifying code.

Example:

```yaml
services:

  database:

    image: mysql:8

    environment:

      MYSQL_ROOT_PASSWORD: root123
      MYSQL_DATABASE: mydb
```

Container starts with those variables.

---

# Using .env File

Create:

```
.env
```

Example:

```
MYSQL_PASSWORD=password123

MYSQL_DATABASE=mydb
```

Compose:

```yaml
services:

  database:

    image: mysql:8

    environment:

      MYSQL_ROOT_PASSWORD: ${MYSQL_PASSWORD}
      MYSQL_DATABASE: ${MYSQL_DATABASE}
```

Advantages:

- Cleaner configuration
- Easy environment changes
- Keeps secrets outside Compose file (for development)

---

# depends_on

Sometimes one service depends on another.

Example:

```
Frontend

↓

Backend

↓

Database
```

Compose:

```yaml
services:

  backend:

    depends_on:
      - database

  database:
    image: mysql:8
```

Docker starts database before backend.

> Note: `depends_on` controls startup order only. It does not wait until the database is fully ready.

---

# Scaling Services

Docker Compose can create multiple instances of a service.

Example:

```bash
docker compose up --scale web=3
```

Creates:

```
Web-1

Web-2

Web-3
```

Useful for:

- Load testing
- High availability
- Multiple workers

---

# Common Docker Compose Commands

### Start services

```bash
docker compose up
```

---

### Start in background

```bash
docker compose up -d
```

---

### Stop services

```bash
docker compose down
```

---

### Restart services

```bash
docker compose restart
```

---

### View running containers

```bash
docker compose ps
```

---

### View logs

```bash
docker compose logs
```

---

### Follow logs

```bash
docker compose logs -f
```

---

### Build images

```bash
docker compose build
```

---

### Pull latest images

```bash
docker compose pull
```

---

### Execute command inside container

```bash
docker compose exec backend bash
```

---

### Scale containers

```bash
docker compose up --scale backend=3
```

---

# Complete Example

```yaml
version: "3.9"

services:

  frontend:
    image: nginx
    ports:
      - "80:80"

  backend:
    image: node:20

    ports:
      - "3000:3000"

    environment:
      DB_HOST: database

    depends_on:
      - database

  database:
    image: mysql:8

    environment:
      MYSQL_ROOT_PASSWORD: root123

    volumes:
      - mysql-data:/var/lib/mysql

volumes:
  mysql-data:
```

Start:

```bash
docker compose up -d
```

Stop:

```bash
docker compose down
```

---

# Best Practices

- Keep one `docker-compose.yml` per project.
- Use meaningful service names.
- Store persistent data in volumes.
- Use `.env` files for configuration.
- Avoid hardcoding secrets.
- Use custom networks for isolation.
- Keep Compose files simple and readable.
- Use version control (Git) to track Compose changes.
- Remove unused containers and volumes regularly.
- Use `docker compose down` to clean up resources.

---

# Real-World Example

A typical web application stack:

```
                    Internet
                        │
                        ▼
                Nginx (Frontend)
                        │
                        ▼
              Node.js (Backend API)
                        │
          ┌─────────────┴─────────────┐
          ▼                           ▼
     MySQL Database              Redis Cache
```

Docker Compose starts and manages all these services together using a single configuration file.

---

# Summary

In this chapter, you learned:

- ✅ What Docker Compose is
- ✅ Why Docker Compose is important
- ✅ Understanding `docker-compose.yml`
- ✅ Services
- ✅ Multi-Container Applications
- ✅ Docker Networks
- ✅ Volumes
- ✅ Environment Variables
- ✅ Using `.env` files
- ✅ `depends_on`
- ✅ Scaling services
- ✅ Essential Docker Compose commands
- ✅ Best practices
- ✅ Real-world architecture

Docker Compose simplifies the development and management of multi-container applications, making it an essential tool for every DevOps Engineer.