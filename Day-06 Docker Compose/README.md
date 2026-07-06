
# 🐳 Docker Learning Series – Day 6

# Docker Compose

> **Topics Covered:** Docker Compose • docker-compose.yml • Services • Multi-Container Applications • Networks • Volumes • Environment Variables • Scaling

---

# 📖 What is Docker Compose?

Docker Compose is a tool used to define, configure, and manage **multi-container Docker applications** using a single YAML file called **docker-compose.yml**.

Instead of manually creating containers, networks, volumes, and passing environment variables, Compose automates the entire application deployment.

```bash
docker compose up -d
```

This single command can start an entire application stack.

---

# Why Docker Compose?

Modern applications are built using multiple services.

Example:

```text
Browser
   │
   ▼
Nginx
   │
   ▼
Backend API
   │
   ▼
MySQL
   │
   ▼
Redis
```

Without Compose you would manually:

- Create each container
- Create Docker network
- Create volumes
- Configure environment variables
- Connect containers

Compose performs all of these automatically.

---

# Docker Compose Workflow

```text
Write docker-compose.yml
        │
        ▼
docker compose up
        │
        ▼
Build/Pull Images
        │
        ▼
Create Network
        │
        ▼
Create Volumes
        │
        ▼
Start Containers
        │
        ▼
Application Ready
```

---

# docker-compose.yml

This file describes your complete application.

It typically contains:

- Services
- Images
- Build instructions
- Ports
- Networks
- Volumes
- Environment Variables
- Health Checks
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

---

# Services

A **service** defines one container.

Example:

```yaml
services:
  frontend:
    image: nginx

  backend:
    image: node:20

  database:
    image: mysql:8

  redis:
    image: redis:7
```

Each service runs independently but communicates over the Compose network.

### Real-Time Example

E-commerce Application

- frontend → React
- backend → Spring Boot
- database → MySQL
- cache → Redis

Each is defined as a separate service.

---

# Multi-Container Applications

Most enterprise applications contain multiple containers.

Example Architecture

```text
                 Internet
                     │
                     ▼
               Nginx Reverse Proxy
                     │
          ┌──────────┴──────────┐
          ▼                     ▼
      Backend API          Background Worker
              │
      ┌───────┴────────┐
      ▼                ▼
   MySQL            Redis
```

### Why Multiple Containers?

- Better scalability
- Independent deployment
- Easier maintenance
- Fault isolation
- Technology flexibility

### Real Project Example

Online Shopping Platform

- Nginx
- Spring Boot API
- MySQL
- Redis
- RabbitMQ

All started using one Compose file.

---

# Networks

Compose automatically creates a bridge network.

Containers communicate using **service names**.

Example:

```text
backend → database:3306
```

instead of IP addresses.

### Custom Network

```yaml
networks:
  app-network:

services:
  backend:
    networks:
      - app-network

  database:
    networks:
      - app-network
```

Benefits

- Service discovery
- Isolation
- Secure communication

---

# Volumes

Containers are temporary.

Volumes keep data persistent.

```yaml
services:
  mysql:
    image: mysql:8
    volumes:
      - mysql-data:/var/lib/mysql

volumes:
  mysql-data:
```

### Bind Mount

```yaml
volumes:
  - ./:/app
```

Best for development because code changes appear instantly inside the container.

---

# Environment Variables

Instead of hardcoding values:

```yaml
environment:
  MYSQL_ROOT_PASSWORD: root123
```

Use `.env`

```
MYSQL_PASSWORD=root123
MYSQL_DATABASE=shopping
```

```yaml
environment:
  MYSQL_ROOT_PASSWORD: ${MYSQL_PASSWORD}
  MYSQL_DATABASE: ${MYSQL_DATABASE}
```

Benefits

- Cleaner configuration
- Environment-specific values
- Easy deployment

---

# depends_on

```yaml
backend:
  depends_on:
    - database
```

**Important:** It controls startup order only. It does not guarantee the database is ready. Use **healthcheck** in production.

---

# Scaling

```bash
docker compose up --scale backend=3
```

Output

```text
backend-1
backend-2
backend-3
```

Useful for:

- Load testing
- Background workers
- High availability

---

# Complete Project Structure

```text
shopping-app/
├── docker-compose.yml
├── .env
├── frontend/
├── backend/
├── nginx/
└── database/
```

---

# Complete Compose Example

```yaml
version: "3.9"

services:
  frontend:
    image: nginx
    ports:
      - "80:80"

  backend:
    image: node:20
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

  redis:
    image: redis:7

volumes:
  mysql-data:
```

---

# Common Commands

```bash
docker compose up -d
docker compose down
docker compose ps
docker compose logs -f
docker compose restart
docker compose exec backend bash
docker compose build
docker compose pull
docker compose config
docker compose up --scale backend=3
```

---

# Sample Output

## docker compose ps

```text
NAME         STATUS    PORTS
frontend     Up        80/tcp
backend      Up        3000/tcp
database     Up        3306/tcp
redis        Up        6379/tcp
```

## docker compose logs

```text
backend | Connected to MySQL
backend | Server started on port 3000
database | Ready for connections
redis | Ready to accept connections
```

---

# Common Troubleshooting

### Port already allocated

```text
ERROR: Port is already allocated
```

Fix:

```bash
docker ps
docker stop <container-id>
```

### Connection refused

Reason:

Database is not ready.

Solution

- Use healthcheck
- Retry connection
- Don't rely only on depends_on

### No such service

```bash
docker compose config
```

Verify service names.

---

# Production Best Practices

- Use `.env`
- Never hardcode passwords
- Use Docker Secrets in production
- Use named volumes
- Pin image versions
- Add health checks
- Keep separate development and production Compose files
- Store Compose files in Git
- Clean unused images and volumes

---

# Top 15 Interview Questions

1. What is Docker Compose?
2. Difference between Docker and Docker Compose?
3. What is docker-compose.yml?
4. What is a service?
5. What happens during `docker compose up`?
6. How do containers communicate?
7. What is depends_on?
8. Difference between Volume and Bind Mount?
9. Why use .env?
10. Difference between `up`, `start`, `stop`, and `down`?
11. How do you scale services?
12. What is a healthcheck?
13. How do you debug Compose applications?
14. How would you deploy Compose in a Dev environment?
15. What are Compose production best practices?

### Short Answers

- Compose manages multi-container applications.
- Services define containers.
- Networks provide service discovery.
- Volumes persist data.
- Environment variables externalize configuration.
- Scaling creates multiple container replicas.
- Health checks improve reliability.
- Logs and `docker compose exec` are used for troubleshooting.
- `.env` improves portability.
- Production should use secrets, health checks, pinned versions, and Git.

---

# Summary

By completing Day 6, you learned:

- ✅ Docker Compose
- ✅ docker-compose.yml
- ✅ Services
- ✅ Multi-Container Applications
- ✅ Networks
- ✅ Volumes
- ✅ Environment Variables
- ✅ depends_on
- ✅ Scaling
- ✅ Complete Project Example
- ✅ Sample Outputs
- ✅ Troubleshooting
- ✅ Production Best Practices
- ✅ Top Interview Questions

Docker Compose is one of the most important tools for DevOps Engineers because it simplifies local development, testing, CI/CD pipelines, and multi-container application management.
