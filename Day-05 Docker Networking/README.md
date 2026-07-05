# 🐳 Docker Learning Series – Day 5: Docker Networking

Welcome to **Day 5** of the **Docker Learning Series**!

Docker Networking is one of the most important concepts in containerization. It enables communication between containers, the host machine, and external networks while providing isolation, service discovery, and secure connectivity.

This repository contains comprehensive notes, commands, practical examples, and a visual infographic to help you understand Docker Networking from beginner to intermediate level.

---

## 📚 Topics Covered

- 🌐 What is Docker Networking?
- 🌉 Bridge Network
- 🚀 Host Network
- 🔒 None Network
- 🔗 Overlay Network
- 🌐 Macvlan Network
- 🚪 Port Mapping
- 🛰 Docker DNS & Service Discovery
- 💻 Essential Docker Network Commands
- 🏗️ Bridge Network Architecture
- ✅ Production Best Practices
- 🎯 Docker Networking Interview Questions

---

# 📂 Repository Structure

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

# 📖 File Description

| File | Description |
|------|-------------|
| **README.md** | Repository overview |
| **Docker Networking.md** | Complete theory and explanation of Docker Networking |
| **commands.md** | Frequently used Docker networking commands |
| **examples.md** | Practical networking examples with outputs |
| **Dockerfile** | Sample Dockerfile for networking demonstration |
| **docker networking.png** | High-resolution handwritten infographic |
| **docker networking.pdf** | Printable PDF version of the infographic |

---

# 🎯 Learning Objectives

After completing this module, you'll be able to:

- Understand Docker networking fundamentals
- Explain how containers communicate
- Differentiate between all Docker network drivers
- Configure Bridge, Host, Overlay, None, and Macvlan networks
- Expose applications using Port Mapping
- Use Docker DNS for service discovery
- Manage Docker networks using CLI
- Apply networking best practices in production
- Prepare for Docker & DevOps interviews

---

# 💻 Common Docker Networking Commands

```bash
docker network ls
docker network inspect bridge
docker network create app-network
docker network connect app-network container
docker network disconnect app-network container
docker network rm app-network
docker port container-name
docker inspect container-name
```

---

# 🚀 Hands-on Examples Included

✔ Creating custom Docker networks

✔ Running containers on custom networks

✔ Port Mapping

✔ Docker DNS communication

✔ Inspecting Docker networks

✔ Connecting and disconnecting containers

✔ Verifying container communication

---

# 🏗️ Docker Networking Architecture

```
                Internet
                    │
             Host Machine
                    │
             Docker Engine
                    │
             Docker Network
         ┌────────┼────────┐
         │        │        │
 Container A  Container B  Container C
```

---

# 📌 Key Takeaways

- Bridge is the default Docker network.
- User-defined Bridge networks provide automatic DNS resolution.
- Host networking offers maximum performance but less isolation.
- Overlay networks enable communication across multiple Docker hosts.
- Macvlan allows containers to appear as physical devices on the LAN.
- Port Mapping exposes container services to external users.
- Docker DNS eliminates the need for hardcoded IP addresses.

---

# 📚 Prerequisites

- Basic Linux knowledge
- Docker installed on your system
- Familiarity with Docker Images and Containers

---

# 🎯 Who Should Use This Repository?

- DevOps Engineers
- Cloud Engineers
- Platform Engineers
- SREs
- Docker Beginners
- Kubernetes Learners
- Students preparing for Docker Certification
- Anyone preparing for DevOps Interviews

---

# 🔗 Docker Learning Series Progress

- ✅ Day 1 – Docker Fundamentals
- ✅ Day 2 – Docker Installation & Basic Commands
- ✅ Day 3 – Docker Images & Image Lifecycle
- ✅ Day 4 – Docker Volumes & Data Persistence
- ✅ **Day 5 – Docker Networking**

More Docker topics coming soon! 🚀

---

## ⭐ Support

If you found this repository helpful:

⭐ Star this repository

🍴 Fork it

📢 Share it with the DevOps community

💬 Connect with me on LinkedIn and follow my Docker Learning Series!

Happy Learning! 🐳🚀