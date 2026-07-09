# Day 09 — Docker Security 🔐

Part of my **100 Days of DevOps** series.

## 📌 What's inside

| File | Content |
|---|---|
| `theory.md` | Core Docker security concepts explained simply |
| `docker-security.md` | Deep dive — namespaces, cgroups, capabilities, seccomp, AppArmor |
| `best-practices.md` | Production-grade hardening checklist (AWS/EKS context) |
| `commands.md` | Handy CLI commands for scanning & hardening images |
| `examples.md` | Real scenarios from IBM Watsonx/EKS clusters |
| `interview-questions.md` | Scenario-based Q&A for DevOps/SRE interviews |
| `Dockerfile` | A hardened, multi-stage, non-root sample Dockerfile |

## 🎯 Why Docker Security matters

A misconfigured container can become the easiest way into your entire
Kubernetes cluster — root access, exposed secrets, lateral movement across
pods, you name it. On platforms like AWS EKS running production workloads
(e.g. Watsonx-style AI platforms), one leaked IAM role attached to a pod
can blow way past just "one container."

## 🔗 Connect

Follow the full 10 Days of DevOps series on GitHub & LinkedIn.
