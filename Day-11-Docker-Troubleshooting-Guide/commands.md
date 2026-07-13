# Docker Troubleshooting Commands

## Introduction

Docker provides several built-in commands that help DevOps Engineers troubleshoot production issues quickly. Understanding when and how to use these commands can significantly reduce Mean Time to Recovery (MTTR).

This guide covers the most commonly used troubleshooting commands with examples and sample outputs.

---

# 1. List Running Containers

## Command

```bash
docker ps
```

## Purpose

Displays all currently running containers.

## Sample Output

```text
CONTAINER ID   IMAGE        STATUS         PORTS
8a2d5c7b91a1   nginx:latest Up 5 minutes   0.0.0.0:8080->80/tcp
```

## When to Use

- Verify whether a container is running
- Check mapped ports
- Confirm uptime

---

# 2. List All Containers

## Command

```bash
docker ps -a
```

## Purpose

Displays both running and stopped containers.

## Sample Output

```text
CONTAINER ID   IMAGE       STATUS
c91a73d9f11b   ubuntu      Exited (1) 5 minutes ago
```

## When to Use

- Identify crashed containers
- View exit status

---

# 3. View Container Logs

## Command

```bash
docker logs <container-name>
```

Example

```bash
docker logs nginx
```

## Sample Output

```text
2026/07/13 12:20:01 Starting Nginx...
2026/07/13 12:20:02 Server Ready
```

## When to Use

- Application crashes
- Startup failures
- Runtime errors

---

# 4. Follow Live Logs

```bash
docker logs -f nginx
```

Sample Output

```text
GET /index.html 200
GET /favicon.ico 404
```

Use when monitoring a running application.

---

# 5. Inspect Container

```bash
docker inspect nginx
```

Purpose

Displays complete container metadata.

Useful Information

- IP Address
- Volumes
- Environment Variables
- Restart Policy
- Mounts
- Health Status

---

# 6. Execute Commands Inside Container

```bash
docker exec -it nginx /bin/sh
```

Sample

```text
/app #
```

Use to

- Inspect files
- Verify configurations
- Test connectivity
- Debug applications

---

# 7. Display Resource Usage

```bash
docker stats
```

Sample Output

```text
CONTAINER CPU % MEM USAGE / LIMIT
nginx     2.1%  25MiB / 512MiB
mysql     18%   420MiB / 2GiB
```

Use when

- High CPU
- High Memory
- Performance investigation

---

# 8. View Docker Events

```bash
docker events
```

Sample Output

```text
container start nginx
container die nginx
container restart nginx
```

Use for

- Container lifecycle monitoring
- Unexpected restarts

---

# 9. Show Docker Disk Usage

```bash
docker system df
```

Sample Output

```text
TYPE            TOTAL ACTIVE SIZE
Images          12    5      2.3GB
Containers      8     3      120MB
Volumes         6     4      1.5GB
```

Use when

Disk usage is high.

---

# 10. Remove Unused Resources

```bash
docker system prune
```

Removes

- Stopped containers
- Unused networks
- Build cache

Production Tip

Never run this command without verifying what will be deleted.

---

# 11. Remove Unused Images

```bash
docker image prune
```

Removes dangling images.

---

# 12. List Images

```bash
docker images
```

Sample Output

```text
REPOSITORY TAG IMAGE ID SIZE

nginx latest ab12cd34ef56 187MB
```

Useful for verifying downloaded images.

---

# 13. Search Docker Images

```bash
docker search nginx
```

Used before pulling new images.

---

# 14. Pull Docker Image

```bash
docker pull nginx:latest
```

Downloads an image from Docker Hub.

---

# 15. Check Docker Networks

```bash
docker network ls
```

Sample Output

```text
NETWORK ID NAME DRIVER

bridge bridge bridge

host host host
```

Useful during networking issues.

---

# 16. Inspect Docker Network

```bash
docker network inspect bridge
```

Displays

- Connected containers
- Gateway
- Subnet
- Driver

---

# 17. List Volumes

```bash
docker volume ls
```

Useful when troubleshooting persistent storage.

---

# 18. Inspect Volume

```bash
docker volume inspect myvolume
```

Shows

- Mountpoint
- Driver
- Labels

---

# 19. Copy Files from Container

```bash
docker cp nginx:/etc/nginx/nginx.conf .
```

Useful for

- Configuration backup
- Log extraction

---

# 20. Check Container Processes

```bash
docker top nginx
```

Displays running processes inside a container.

---

# 21. Show Port Mappings

```bash
docker port nginx
```

Sample Output

```text
80/tcp -> 0.0.0.0:8080
```

Useful when verifying published ports.

---

# 22. Restart Container

```bash
docker restart nginx
```

Use after configuration changes.

---

# 23. Stop Container

```bash
docker stop nginx
```

Gracefully stops a running container.

---

# 24. Start Container

```bash
docker start nginx
```

Starts a stopped container.

---

# 25. Remove Container

```bash
docker rm nginx
```

Deletes a stopped container.

---

# 26. Check Container Health

```bash
docker inspect --format='{{.State.Health.Status}}' nginx
```

Sample Output

```text
healthy
```

---

# 27. Display Environment Variables

```bash
docker exec nginx env
```

Useful for debugging configuration issues.

---

# 28. Test Network Connectivity

```bash
docker exec nginx ping google.com
```

Verifies outbound connectivity.

---

# 29. Verify DNS Resolution

```bash
docker exec nginx nslookup google.com
```

Useful for DNS troubleshooting.

---

# 30. Check Running Processes

```bash
docker exec nginx ps -ef
```

Confirms the main application is running.

---

# Quick Troubleshooting Workflow

| Problem | First Command |
|----------|---------------|
| Container stopped | `docker ps -a` |
| Application crash | `docker logs` |
| Configuration issue | `docker inspect` |
| Network problem | `docker network inspect` |
| DNS issue | `nslookup` |
| High CPU | `docker stats` |
| Storage issue | `docker system df` |
| Volume issue | `docker volume inspect` |
| Process issue | `docker exec ps -ef` |
| Health check failure | `docker inspect` |

---

# Production Best Practices

- Always check `docker logs` before restarting a container.
- Use `docker inspect` to verify environment variables, mounts, and networking.
- Monitor resource usage with `docker stats`.
- Regularly clean unused resources using `docker system prune`.
- Prefer named volumes over bind mounts for persistent data.
- Enable HEALTHCHECK in production images.
- Document common troubleshooting commands for faster incident response.
