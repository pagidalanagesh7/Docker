# 🐳 Docker Learning Series – Day 10
## Docker Container Lifecycle & Resource Management

> Part of the **#100DaysOfDevOps** series — production context: AWS EKS, ECR, Watsonx-style microservices.

---

## 📌 Table of Contents
- [1. Container Lifecycle](#1-container-lifecycle)
- [2. Lifecycle Commands](#2-lifecycle-commands)
- [3. Restart Policies](#3-restart-policies)
- [4. Health Checks](#4-health-checks)
- [5. Resource Management (CPU/Memory)](#5-resource-management-cpumemory)
- [6. Signals & Graceful Shutdown](#6-signals--graceful-shutdown)
- [7. Production Best Practices](#7-production-best-practices)
- [8. Interview Questions](#8-interview-questions)

---

## 1. Container Lifecycle

Every container goes through a defined lifecycle from creation to removal:

```
docker create → Created → docker start → Running
                                             │
                        ┌────────────────────┼───────────────────┐
                        ▼                    ▼                   ▼
                     Paused             Restarting            (running)
                        │                    │
                  docker unpause       (auto on failure)
                        ▼
                     Running
                        │
                   docker stop
                        ▼
                     Exited
                        │
                    docker rm
                        ▼
                    Removed
```

**Key notes:**
- Containers are immutable runtime instances of images — the image is never modified, only the writable container layer changes.
- Understanding lifecycle states is essential for debugging `CrashLoopBackOff`-style issues when containers run inside EKS pods.

---

## 2. Lifecycle Commands

| Command | Purpose |
|---|---|
| `docker create nginx` | Create a container without starting it |
| `docker start <container>` | Start an existing (stopped) container |
| `docker stop <container>` | Gracefully stop (SIGTERM → SIGKILL) |
| `docker restart <container>` | Restart a container |
| `docker pause <container>` | Freeze all processes in the container |
| `docker unpause <container>` | Resume a paused container |
| `docker kill <container>` | Force terminate immediately (SIGKILL) |
| `docker rm <container>` | Remove a stopped container |

> ⚠️ `docker stop` sends **SIGTERM**, waits (default 10s), then sends **SIGKILL** if the process hasn't exited.
> `docker kill` skips straight to **SIGKILL** — no cleanup.

---

## 3. Restart Policies

| Policy | Behavior |
|---|---|
| `no` | Never restart (default) |
| `on-failure[:max-retries]` | Restart only if the container exits with a non-zero code |
| `always` | Always restart, even after Docker daemon restarts |
| `unless-stopped` | Same as `always`, but respects manual `docker stop` |

```bash
docker run -d \
  --restart=unless-stopped \
  nginx
```

✅ **Production recommendation:** use `unless-stopped` for most long-running services — it self-heals on crash/reboot but won't fight you when you intentionally stop it (relevant when running standalone Docker on an EC2 bastion/tooling box outside EKS).

---

## 4. Health Checks

```dockerfile
HEALTHCHECK --interval=30s --timeout=5s --retries=3 \
  CMD curl -f http://localhost/ || exit 1
```

```
Container → Health Check → Healthy / Unhealthy
```

```bash
docker ps
# STATUS
# Up 5 minutes (healthy)
# Up 2 minutes (unhealthy)
```

- Healthy containers enable automated recovery and are the standalone-Docker equivalent of Kubernetes **liveness/readiness probes** used on EKS.
- An `unhealthy` status alone doesn't restart the container in plain Docker — pair it with a restart policy or an orchestrator (EKS) for real self-healing.

---

## 5. Resource Management (CPU/Memory)

```bash
docker run -d \
  --cpus=2 \
  --memory=512m \
  nginx
```

```bash
docker stats
# CONTAINER   CPU     MEMORY           NETWORK
# nginx       0.42%   42MiB / 512MiB   1.4MB / 900KB
```

**Why it matters:**
- Prevents memory exhaustion / OOM-killed containers
- Avoids the "noisy neighbour" problem on shared EC2 nodes
- Mirrors Kubernetes `resources.requests` / `resources.limits` set on EKS pod specs — good habit before your workload ever reaches a cluster

---

## 6. Signals & Graceful Shutdown

```
docker stop → SIGTERM → App cleanup → Exit successfully
                 │
          (timeout expires)
                 ▼
              SIGKILL
```

| Signal | Meaning |
|---|---|
| `SIGTERM` | Polite request to shut down — app can flush buffers, close DB connections, finish in-flight requests |
| `SIGKILL` | Immediate, non-negotiable termination — no cleanup possible |

⚠️ Applications that ignore `SIGTERM` risk data corruption or dropped requests once `SIGKILL` hits — handle it explicitly in your app (same principle applies to `terminationGracePeriodSeconds` in EKS pod specs).

---

## 7. Production Best Practices

- ✅ Configure `HEALTHCHECK` in every Dockerfile
- ✅ Set explicit CPU limits (`--cpus`)
- ✅ Set explicit memory limits (`--memory`)
- ✅ Use `unless-stopped` (or orchestrator-level restart policy on EKS)
- ✅ Handle `SIGTERM` in application code
- ✅ Regularly prune unused/stopped containers (`docker container prune`)
- ✅ Monitor with `docker stats` / CloudWatch Container Insights
- ✅ Keep containers lightweight (multi-stage builds, minimal base images)
- ✅ Push clean, versioned images to ECR — don't rely on `latest` in production

---

## 8. Interview Questions

1. What's the difference between `docker stop` and `docker kill`?
2. What is a `HEALTHCHECK` and how does Docker use it?
3. Which restart policy is best for production, and why?
4. How do you limit a container's memory and CPU usage?
5. What happens when a container becomes `unhealthy`? Does Docker restart it automatically?
6. How does `docker stop`'s SIGTERM/SIGKILL flow relate to Kubernetes pod termination on EKS?

---

## 📌 Production Container Workflow

```
Image → docker create → Created → docker start → Running
       → Health Check → Resource Monitoring → Graceful Shutdown
       → Exited → Removed
```

---

🚀 Follow for more DevOps & Cloud notes — **#100DaysOfDevOps**
