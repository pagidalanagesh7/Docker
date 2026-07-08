# Day 08 - Docker Registry 🐳📦

## 10 Days of DevOps Series

In this day, we take a deep dive into **Docker Registry** concepts — from Docker Hub to AWS ECR (Elastic Container Registry), with real IBM Watsonx/EKS scenarios.

## 📚 Contents

| File | Description |
|---|---|
| [theory.md](./theory.md) | What is a registry and how it works - core concepts |
| [registry-architecture.md](./registry-architecture.md) | Registry internal architecture (blobs, manifests, layers) |
| [dockerhub.md](./dockerhub.md) | Docker Hub deep dive - public/private repos, rate limits |
| [commands.md](./commands.md) | Push/pull/tag/login commands - practical usage |
| [examples.md](./examples.md) | Real-world examples - Docker Hub + AWS ECR workflows |
| [interview-questions.md](./interview-questions.md) | Scenario-based interview Q&A |
| [best-practices.md](./best-practices.md) | Production-grade registry best practices |
| [demo-app/](./demo-app/) | Sample app to build → tag → push demo |
| [cheatsheet/](./cheatsheet/docker-registry-cheatsheet.md) | Quick reference cheatsheet |

## 🎯 Learning Goals

- Understand how Docker Registry works internally
- Docker Hub vs AWS ECR vs private registries (Harbor, GitHub Container Registry)
- Image tagging strategies (semantic versioning, risks of `latest`)
- Authentication mechanisms (`docker login`, IAM roles, ECR auth tokens)
- Real incident: how we debugged an image pull error on IBM Watsonx EKS

## 🔗 Connect

Part of my **100 Days of DevOps** journey - follow along on LinkedIn and GitHub!

---
⬅️ [Day 07 - Dockerfile Optimization](../Day-07-Dockerfile-Optimization/) | ➡️ Day 09 (Coming soon)
