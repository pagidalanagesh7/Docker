# Day 07 - Dockerfile & Image Optimization

## 📌 Overview
Day 7 of the DevOps learning series covers **Dockerfile best practices** and **Docker image optimization** techniques. This module focuses on how to write efficient Dockerfiles and reduce image size using multi-stage builds, layer caching, and language-specific optimizations across Node.js, Python, Java, and Nginx.

## 🎯 Learning Objectives
- Understand Dockerfile instructions and their impact on image size/build time
- Learn multi-stage builds to separate build-time and run-time dependencies
- Apply `.dockerignore` to reduce build context
- Optimize images for Node.js, Python, Java, and Nginx-based applications
- Understand caching layers and how instruction order affects rebuilds
- Learn security best practices (non-root users, minimal base images)

## 📂 Folder Structure
```
Day-07-Dockerfile-Image-Optimization/
│── README.md
├── theory.md
├── commands.md
├── examples.md
├── interview-questions.md
├── best-practices.md
├── dockerfiles/
│   ├── nodejs/
│   ├── python/
│   ├── java/
│   └── nginx/
```

## 📖 How to Use This Repo
1. Read `theory.md` for core concepts.
2. Try out commands from `commands.md` on your local Docker setup.
3. Explore language-specific Dockerfiles in the `dockerfiles/` folder.
4. Check `examples.md` for before/after image size comparisons.
5. Review `interview-questions.md` before interviews.
6. Follow `best-practices.md` as a quick-reference checklist.

## 🛠 Prerequisites
- Docker installed (`docker --version`)
- Basic understanding of containers and images (Day 1-6 topics)

## 🔗 Related Topics
- Day 06: Docker Networking & Volumes
- Day 08: Docker Compose Multi-Container Apps

---
✍️ Part of the **100 Days of DevOps** learning series by Nagesh
