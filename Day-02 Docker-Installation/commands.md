````markdown
# 🐳 Docker Day 02 - Docker Commands Cheat Sheet

This document contains the most commonly used Docker commands for beginners.

---

# Check Docker Version

```bash
docker --version
```

Displays the installed Docker version.

---

# Detailed Version Information

```bash
docker version
```

Shows Docker Client and Docker Server information.

---

# Docker System Information

```bash
docker info
```

Displays detailed information about the Docker Engine.

---

# Download and Run First Container

```bash
docker run hello-world
```

Downloads the **hello-world** image (if not available locally) and runs a test container.

---

# List Docker Images

```bash
docker images
```

Displays all downloaded Docker images.

Example:

```text
REPOSITORY    TAG       IMAGE ID
nginx         latest    xxxxxxxxx
ubuntu        latest    xxxxxxxxx
```

---

# List Running Containers

```bash
docker ps
```

Displays only running containers.

---

# List All Containers

```bash
docker ps -a
```

Displays both running and stopped containers.

---

# Run a Container

```bash
docker run nginx
```

Runs an Nginx container.

---

# Run Container in Detached Mode

```bash
docker run -d nginx
```

Runs the container in the background.

---

# Port Mapping

```bash
docker run -d -p 8080:80 nginx
```

Maps:

- Host Port → **8080**
- Container Port → **80**

Access:

```
http://localhost:8080
```

---

# Stop a Container

```bash
docker stop <container_id>
```

Stops a running container.

---

# Start a Container

```bash
docker start <container_id>
```

Starts a stopped container.

---

# Restart a Container

```bash
docker restart <container_id>
```

Restarts a container.

---

# Remove a Container

```bash
docker rm <container_id>
```

Deletes a stopped container.

---

# View Container Logs

```bash
docker logs <container_id>
```

Shows application logs from a container.

---

# Execute Commands Inside a Container

```bash
docker exec -it <container_id> bash
```

Opens an interactive Bash shell inside the container.

---

# Build Docker Image

```bash
docker build -t my-first-image .
```

Builds a Docker image using the Dockerfile in the current directory.

---

# Run Docker Image

```bash
docker run my-first-image
```

Runs the Docker image you built.

---

# Remove Docker Image

```bash
docker rmi <image_id>
```

Deletes a Docker image from the local system.

---

# Docker Container Lifecycle

```text
Image
   │
   ▼
Created
   │
   ▼
Running
   │
   ▼
Stopped
   │
   ▼
Removed
```

---

# Summary

By learning these commands, you can:

- Install and verify Docker
- Run your first container
- View images and containers
- Start, stop, and remove containers
- Build Docker images
- Expose applications using port mapping
- Inspect container logs
- Execute commands inside a running container

Happy Learning! 🐳🚀
````
