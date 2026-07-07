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
│
├── README.md
├── Docker Networking.md
├── commands.md
├── examples.md
├── Dockerfile
├── docker networking.png
└── docker networking.pdf
```
---

## 📄 Repository Files

| File | Description |
|------|-------------|
| 📘 Docker Networking.md | Complete theory with detailed explanations |
| 💻 commands.md | Frequently used Docker networking commands |
| 🚀 examples.md | Hands-on examples with command outputs |
| 🐳 Dockerfile | Sample Dockerfile for networking demonstration |
| 🖼 docker networking.png | High-resolution handwritten infographic |
| 📄 docker networking.pdf | Printable PDF version |

---

## 🎯 Learning Objectives

By the end of this module, you will be able to:

- Understand Docker networking fundamentals
- Differentiate between Bridge, Host, None, Overlay, and Macvlan networks
- Expose container applications using Port Mapping
- Configure container communication using Docker DNS
- Manage Docker networks using CLI commands
- Apply networking best practices in production environments

---
# 🐳 Docker Learning Series – Day 6: Docker Compose

Welcome to **Day 6** of the Docker Learning Series!

In this module, you'll learn how to define and run multi-container Docker applications using Docker Compose. You'll explore the `docker-compose.yml` file structure, services, networks, volumes, and how Compose simplifies managing multi-container environments compared to running containers individually.

## 📚 Topics Covered

- 📝 What is Docker Compose?
- ⚙️ Docker Compose YAML Structure
- 🧩 Services, Networks & Volumes in Compose
- 🔗 Multi-Container Application Setup
- 🌍 Environment Variables in Compose
- 📈 Scaling Services with Compose
- 🔄 Compose Lifecycle Commands (`up`, `down`, `restart`, `logs`)
- ✅ Production Best Practices
- 🎯 Interview Questions & Answers

## 📂 Repository Structure

```
Day-06-Docker-Compose/
│
├── README.md
└── docker compose.png
```

## 📄 Repository Files

| File | Description |
|------|-------------|
| 📘 README.md | Complete theory, examples, and notes for Docker Compose |
| 🖼 docker compose.png | High-resolution handwritten infographic |

---

## 🎯 Learning Objectives

By the end of this module, you will be able to:

- Understand the purpose and benefits of Docker Compose
- Write and structure a `docker-compose.yml` file
- Define multiple services, networks, and volumes in a single file
- Manage multi-container applications with simple Compose commands
- Apply Docker Compose best practices in real-world DevOps workflows

---

# 🐳 Docker Learning Series – Day 7: Dockerfile Mastery (Image Optimization)

Welcome to **Day 7** of the Docker Learning Series!

In this module, you'll learn how to write efficient Dockerfiles and optimize Docker images using multi-stage builds, layer caching, `.dockerignore`, and language-specific best practices across Node.js, Python, Java, and Nginx.

## 📚 Topics Covered

- 📝 Dockerfile Instructions Deep Dive
- 🧱 Docker Image Layers & Caching
- 🏗️ Multi-Stage Builds
- 📦 Choosing the Right Base Image (alpine, slim, distroless, scratch)
- 🚫 `.dockerignore` Best Practices
- 🔐 Security Best Practices (non-root users, image scanning)
- 📉 Real-World Image Size Optimization Examples
- ✅ Production Best Practices
- 🎯 Interview Questions & Answers

## 📂 Repository Structure

```
Day-07-Dockerfile-Image-Optimization/
│
├── README.md
├── theory.md
├── commands.md
├── examples.md
├── interview-questions.md
├── best-practices.md
└── dockerfiles/
    ├── nodejs/
    ├── python/
    ├── java/
    └── nginx/
```

## 📄 Repository Files

| File | Description |
|------|-------------|
| 📘 theory.md | Core Dockerfile & image optimization concepts |
| 💻 commands.md | Build, inspect, and optimize Docker image commands |
| 🚀 examples.md | Before/after optimization examples with size comparisons |
| 🎯 interview-questions.md | Scenario-based interview Q&A |
| ✅ best-practices.md | Quick-reference optimization checklist |
| 🐳 dockerfiles/ | Optimized multi-stage Dockerfiles for Node.js, Python, Java & Nginx |

---

## 🎯 Learning Objectives

By the end of this module, you will be able to:

- Write clean, efficient, and secure Dockerfiles
- Apply multi-stage builds to shrink image size significantly
- Choose the right base image for different use cases
- Optimize layer caching to speed up builds
- Apply Docker image optimization best practices in production and CI/CD pipelines

---


⭐ If you find this repository helpful, consider giving it a **Star** and following the series for more Docker and DevOps content.
