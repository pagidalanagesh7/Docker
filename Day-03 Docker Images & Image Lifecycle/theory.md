# 🐳 Docker Day 03 – Docker Images & Image Lifecycle

## 📖 Introduction

Docker Images are the foundation of Docker containers. Every container you run is created from an image. Think of a Docker Image as a blueprint or template that contains everything required to run an application.

A Docker Image is **immutable (read-only)**, while a Docker Container is a **running instance** of that image.

---

# What is a Docker Image?

A **Docker Image** is a lightweight, standalone, executable package that contains everything required to run an application.

It includes:

- Application Source Code
- Runtime Environment
- Libraries
- Dependencies
- Configuration Files
- Required Packages

Once an image is created, it can be shared and executed consistently across different environments.

---

# Why Docker Images?

Docker Images solve the classic **"It works on my machine"** problem.

### Benefits

- Portable across different systems
- Consistent deployments
- Easy application distribution
- Faster application startup
- Lightweight compared to Virtual Machines
- Reusable across multiple containers
- Version controlled using tags

---

# Docker Image Architecture

```
+----------------------------------+
|        Docker Container          |
+----------------------------------+
               ▲
               │
         docker run
               │
+----------------------------------+
|         Docker Image             |
+----------------------------------+
               ▲
               │
        docker build
               │
+----------------------------------+
|          Dockerfile              |
+----------------------------------+
```

---

# Docker Image Layers

Docker Images are composed of multiple **read-only layers**.

Each instruction in a Dockerfile creates a new layer.

Example:

```
+----------------------------+
| Application Code           |
+----------------------------+
| Dependencies               |
+----------------------------+
| System Packages            |
+----------------------------+
| Ubuntu / Alpine Base Image |
+----------------------------+
```

### Advantages of Layers

- Faster image builds
- Layer caching
- Less disk usage
- Shared between images
- Efficient downloads
- Easy updates

---

# Docker Image Lifecycle

The lifecycle of a Docker Image starts from a Dockerfile.

```
Dockerfile
     │
     ▼
docker build
     │
     ▼
Docker Image
     │
     ├──────────────► docker push
     │                     │
     │                     ▼
     │               Docker Registry
     │                     │
     ▼                     ▼
docker run ◄──────── docker pull
     │
     ▼
Docker Container
```

### Workflow

1. Create a Dockerfile.
2. Build the Docker Image.
3. Tag the Image.
4. Push it to a Registry.
5. Pull the Image on another machine.
6. Run the Container.

---

# Docker Image vs Docker Container

| Docker Image | Docker Container |
|--------------|------------------|
| Read-only | Read & Write |
| Blueprint | Running Instance |
| Immutable | Mutable |
| Cannot Execute | Executes Application |
| Created Once | Multiple Containers can be created |

---

# Docker Hub

Docker Hub is the default public image registry provided by Docker.

It allows developers to:

- Store Docker Images
- Share Images
- Download Images
- Version Images
- Collaborate with Teams

Popular Images:

- ubuntu
- nginx
- redis
- mysql
- postgres
- node
- python
- alpine

---

# Docker Image Tags

Tags are used to identify different versions of an image.

Examples:

```bash
nginx:latest
nginx:1.27
ubuntu:24.04
python:3.12
myapp:v1
myapp:v2
```

Using proper tags helps manage application versions efficiently.

> **Best Practice:** Avoid using the `latest` tag in production environments.

---

# Docker Image ID

Every Docker Image has a unique Image ID.

Example:

```bash
docker images
```

Output:

```
REPOSITORY     TAG       IMAGE ID       SIZE
nginx          latest    a8f5f167f44f   192MB
```

The Image ID uniquely identifies the image on your system.

---

# Public vs Private Registries

## Public Registries

- Docker Hub
- GitHub Container Registry (GHCR)

## Private Registries

- Amazon Elastic Container Registry (ECR)
- Azure Container Registry (ACR)
- Google Artifact Registry
- Private Docker Registry

Private registries are commonly used by organizations to securely store internal images.

---

# Image Caching

Docker caches image layers during the build process.

Benefits:

- Faster builds
- Reduced bandwidth usage
- Less storage consumption
- Improved CI/CD performance

---

# Best Practices

- Use official base images whenever possible.
- Keep images lightweight.
- Prefer Alpine-based images for smaller size.
- Use meaningful image tags.
- Avoid using the `latest` tag in production.
- Remove unused images regularly.
- Minimize the number of layers.
- Use a `.dockerignore` file.
- Scan images for vulnerabilities before deployment.

---

# Key Takeaways

- Docker Images are read-only templates.
- Containers are created from Images.
- Images consist of multiple reusable layers.
- Docker Hub is the default public image registry.
- Image tags help manage versions.
- Layer caching speeds up image builds.
- Following best practices results in smaller, secure, and efficient images.

---

# Summary

Docker Images are one of the core building blocks of Docker. Understanding how images are created, layered, tagged, stored, and shared is essential for building efficient containerized applications.

Mastering Docker Images makes it easier to build reliable CI/CD pipelines, optimize deployments, and efficiently manage applications across development, testing, and production environments.

---

⭐ **Docker Learning Series – Day 03**