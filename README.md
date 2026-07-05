# 🐳 Docker Day 01 - Docker Fundamentals

Welcome to **Day 01** of my **Docker Learning Series**.

## 📚 Topics Covered

- What is Docker?
- Why Containers?
- Virtual Machines vs Containers
- Docker Architecture
- Docker Engine
- Docker Images vs Containers

## 📂 Files

- `README.md` – Day 01 Notes
- `Dockerfile` – My First Docker Example
- `commands.md` – Build & Run Commands

## 🎯 Goal

Understand the fundamentals of Docker and learn how to build and run your first Docker container.

---

# 🐳 Docker Day 02 - Docker Installation & First Container

Welcome to **Day 02** of my Docker Learning Series.

## 📚 Topics Covered

- Docker Installation
- Docker Desktop vs Docker Engine
- Installing Docker on Windows
- Installing Docker on macOS
- Installing Docker on Ubuntu/Linux
- Verify Docker Installation
- Running Your First Container
- Essential Docker Commands
- Running Nginx
- Port Mapping
- Docker Container Lifecycle
- Sample Dockerfile

## 📁 Files

- `README.md` – Day 02 Notes
- `commands.md` – Docker Commands
- `Dockerfile` – Sample Dockerfile

## 🎯 Goal

Install Docker, verify the setup, and run your first container successfully.

---

# 🐳 Docker Day 03 – Docker Images & Image Lifecycle

Welcome to **Day 03** of my Docker Learning Series.

---

## 📚 Topics Covered

- What is a Docker Image?
- Why Docker Images?
- Docker Image Layers
- Docker Image Lifecycle
- Docker Hub
- Docker Image vs Docker Container
- Image Tags & Image IDs
- Public vs Private Registries
- Docker Image Best Practices

---

## 📂 Files

- **README.md** – Day 03 Overview
- **theory.md** – Complete Theory Notes
- **commands.md** – Essential Docker Image Commands
- **examples.md** – Practical Examples
- **Dockerfile** – Sample Dockerfile
- **.dockerignore** – Ignore Unnecessary Files During Build

---

## 🎯 Goal

Understand Docker Images, their lifecycle, layers, and how to efficiently build, manage, and share images using Docker Hub.

---

# 🐳 Docker Learning Series – Day 4

## 📚 Topics Covered

- 💾 Docker Volumes
- 📂 Bind Mounts
- ⚡ tmpfs Mounts
- 🔄 Volume Lifecycle
- 🛡️ Data Persistence
- 💽 Backup & Restore Volumes
- ✅ Production Storage Best Practices

## 🎯 What I Learned

- Difference between **Volumes**, **Bind Mounts**, and **tmpfs**
- How Docker stores persistent data
- When to use each storage type
- Backing up and restoring Docker volumes
- Storage best practices for production environments

## 🛠️ Commands Practiced

```bash
docker volume create
docker volume ls
docker volume inspect
docker volume rm
docker run -v
docker run --mount
docker cp
tar
```

## 🚀 Outcome

Built a solid understanding of Docker storage, data persistence, backup & restore strategies, and production-ready storage practices.

---
# 🐳 Docker Learning Series – Day 5: Docker Networking

Welcome to **Day 5** of the Docker Learning Series!

In this module, you'll learn how Docker enables communication between containers, the host machine, and external networks. You'll explore Docker network drivers, port mapping, built-in DNS, and networking best practices used in real-world DevOps environments.

## 📚 Topics Covered

- 🌐 What is Docker Networking?
- 🌉 Bridge Network
- 🚀 Host Network
- 🔒 None Network
- 🔗 Overlay Network
- 🌐 Macvlan Network
- 🚪 Port Mapping (`-p`)
- 🛰 Docker DNS & Service Discovery
- 💻 Essential Docker Network Commands
- ✅ Production Best Practices
- 🎯 Interview Questions & Answers

## 📂 Repository Structure

```
Day-05-Docker-Networking/
│── README.md
│── theory.md
│── commands.md
│── examples.md
│── interview-questions.md
│── images/
```

## 🎯 Learning Objectives

By the end of this module, you will be able to:

- Understand Docker networking fundamentals
- Differentiate between Bridge, Host, None, Overlay, and Macvlan networks
- Expose container applications using Port Mapping
- Configure container communication using Docker DNS
- Manage Docker networks using CLI commands
- Apply networking best practices in production environments

---

⭐ If you find this repository helpful, consider giving it a **Star** and following the series for more Docker and DevOps content.
