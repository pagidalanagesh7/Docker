# 🐳 Docker Day 1 – Docker Fundamentals

> Learn the fundamentals of Docker, Containers, Docker Architecture, Docker Engine, Images, and Containers.

---

# 📚 Table of Contents

- What is Docker?
- Why Containers?
- Virtual Machines vs Containers
- Docker Architecture
- Docker Engine
- Docker Images vs Containers
- Docker Workflow
- Real-World Example
- Advantages of Docker
- Interview Questions
- Key Takeaways

---

# 🚀 What is Docker?

Docker is an **open-source containerization platform** that allows developers to build, package, ship, and run applications consistently across different environments.

Instead of saying:

> "It works on my machine."

Docker ensures:

> "It works everywhere."

Docker packages an application along with:

- Source Code
- Runtime
- Libraries
- Dependencies
- Environment Variables
- Configuration Files

Everything is bundled into a **Container**.

---

## Traditional Application Deployment

```
Application
     ↓
Operating System
     ↓
Server
```

Problems:

- Different OS versions
- Missing dependencies
- Library conflicts
- Environment mismatch

---

## Docker Deployment

```
Application
+ Dependencies
+ Runtime
+ Libraries
+ Configurations

↓

Docker Image

↓

Docker Container

↓

Runs Anywhere
```

---

# 📦 What is a Container?

A Container is a lightweight, isolated environment that contains everything required to run an application.

Think of it as a portable application package.

It includes:

- Application
- Runtime
- System Libraries
- Dependencies
- Environment Variables

Containers share the host operating system kernel.

---

## Example

Instead of installing:

- Python
- Flask
- Pip
- Libraries

on every server...

You package everything into one Docker Image.

Anyone can run it using:

```bash
docker run myapp
```

No additional installation required.

---

# ❓ Why Containers?

Before containers, applications often failed because environments were different.

Example:

Developer Machine

```
Ubuntu 22.04
Python 3.12
Node 20
```

Production Server

```
Ubuntu 18.04
Python 3.8
Node 16
```

Result:

```
Application Failed
```

Containers solve this by packaging everything together.

---

## Benefits

✅ Consistent Environment

✅ Faster Deployment

✅ Portable

✅ Lightweight

✅ Better Resource Utilization

✅ Easy Scaling

✅ Isolation

---

# 🖥️ Virtual Machines vs Containers

## Virtual Machine

A Virtual Machine virtualizes the hardware.

Each VM contains:

- Guest OS
- Libraries
- Application

Architecture

```
Application
Guest OS
Hypervisor
Host OS
Hardware
```

---

## Container

Containers virtualize the Operating System.

Architecture

```
Application
Libraries
Docker Engine
Host OS
Hardware
```

---

## Comparison

| Feature | Virtual Machine | Container |
|----------|-----------------|-----------|
| Boot Time | Minutes | Seconds |
| Size | GBs | MBs |
| OS | Separate Guest OS | Shares Host Kernel |
| Performance | Slower | Faster |
| Isolation | High | Good |
| Resource Usage | High | Low |
| Startup | Slow | Fast |

---

## Visual Comparison

### Virtual Machines

```
+----------------------+
| VM 1 (Guest OS)      |
+----------------------+

+----------------------+
| VM 2 (Guest OS)      |
+----------------------+

+----------------------+
| Hypervisor           |
+----------------------+

Host OS
Hardware
```

---

### Containers

```
Container 1

Container 2

Container 3

↓

Docker Engine

↓

Host OS

↓

Hardware
```

---

# 🏗 Docker Architecture

Docker follows a Client-Server architecture.

```
+----------------+

Docker Client

(docker CLI)

+--------+-------+
         |
REST API
         |
+--------v-------+

Docker Daemon
(dockerd)

+--------+-------+
         |
------------------------------
| Images
| Containers
| Networks
| Volumes
------------------------------

         |
Docker Registry
(Docker Hub)
```

---

## Components

### Docker Client

The Docker CLI used by users.

Example:

```bash
docker build
docker run
docker pull
docker push
```

---

### Docker Daemon

The background service responsible for:

- Building images
- Running containers
- Managing networks
- Managing volumes

Daemon name:

```
dockerd
```

---

### Docker Registry

Stores Docker Images.

Popular Registry:

Docker Hub

Example:

```bash
docker pull nginx
```

Docker downloads the nginx image from Docker Hub.

---

# ⚙ Docker Engine

Docker Engine is the core software that runs Docker.

It consists of three major components.

---

## 1. Docker Daemon

Runs in the background.

Responsible for:

- Build Images
- Run Containers
- Remove Containers
- Manage Networks

---

## 2. Docker REST API

Acts as communication between:

Docker CLI

↓

Docker Daemon

---

## 3. Docker CLI

The command-line interface used by users.

Examples

```bash
docker ps

docker images

docker run nginx
```

---

# 🖼 Docker Images

A Docker Image is a **read-only template** used to create containers.

Think of it as a blueprint.

It contains:

- Application
- Dependencies
- Runtime
- Libraries
- Configuration

Images cannot change.

---

Example

```
Ubuntu Image

↓

Create

↓

Ubuntu Container
```

---

# 📦 Docker Container

A Container is a running instance of an Image.

Images are static.

Containers are running.

Example

```
Image

↓

docker run

↓

Running Container
```

---

## Simple Analogy

Image

↓

Recipe

Container

↓

Prepared Food

---

# Images vs Containers

| Image | Container |
|---------|-----------|
| Read Only | Running Instance |
| Static | Dynamic |
| Blueprint | Actual Application |
| Can Create Multiple Containers | Runs the Application |
| Immutable | Writable Layer |

---

Example

One Image

```
Ubuntu Image
```

Can create

```
Ubuntu Container 1

Ubuntu Container 2

Ubuntu Container 3
```

---

# Docker Workflow

```
Write Dockerfile

↓

Build Image

↓

Store Image

↓

Run Container

↓

Application Running
```

---

# 🌍 Real-World Example

Imagine a banking application.

Instead of installing:

- Java
- Maven
- Tomcat
- MySQL Drivers

on every server,

you create one Docker Image.

Every environment uses the same image.

```
Developer

↓

Testing

↓

UAT

↓

Production

```

Everything behaves identically.

---

# ✅ Advantages of Docker

- Lightweight
- Fast Startup
- Portable
- Easy Scaling
- Consistent Environment
- Better Resource Utilization
- Simplified Deployment
- Version Control for Applications
- Faster CI/CD Pipelines
- Microservices Friendly

---

# 📝 Interview Questions

### 1. What is Docker?

Docker is an open-source containerization platform used to package applications and their dependencies into lightweight, portable containers.

---

### 2. What is a Container?

A container is an isolated runtime environment that packages an application with all its dependencies.

---

### 3. What is Docker Engine?

Docker Engine is the core runtime responsible for building, running, and managing Docker containers.

---

### 4. Difference between Image and Container?

| Image | Container |
|---------|-----------|
| Template | Running Instance |
| Immutable | Mutable |
| Static | Running Process |

---

### 5. Difference between VM and Container?

VMs include a Guest OS, whereas containers share the host OS kernel, making them faster and more lightweight.

---

# 💡 Key Takeaways

- Docker simplifies application deployment by packaging applications and their dependencies into containers.
- Containers are lightweight, portable, and share the host operating system kernel.
- Virtual Machines virtualize hardware, while containers virtualize the operating system.
- Docker Architecture includes the Docker Client, Docker Daemon, Docker Engine, and Docker Registry.
- Docker Images are read-only templates used to create running Containers.
- One Docker Image can be used to create multiple Containers efficiently.

---

# 📖 What's Next?

➡️ **Day 2 – Installing Docker & Your First Container**

Topics:

- Install Docker on Linux
- Install Docker on Windows
- Install Docker on macOS
- Docker CLI Basics
- `docker run`
- `docker pull`
- `docker ps`
- `docker images`
- `docker version`
- Running Your First Container

Happy Learning! 🐳🚀