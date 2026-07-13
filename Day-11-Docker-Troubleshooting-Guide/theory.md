# Docker Troubleshooting Guide – Theory

## Introduction

Docker has become the standard containerization platform used by organizations of all sizes. While Docker makes application deployment easier, production environments often experience issues such as container crashes, networking failures, storage problems, permission errors, and high resource utilization.

A DevOps Engineer's responsibility is not just running containers but also identifying problems quickly, minimizing downtime, and restoring services efficiently.

This guide explains the most common Docker production problems, their root causes, and recommended troubleshooting approaches.

---

# Docker Troubleshooting Workflow

Whenever a production issue occurs, avoid randomly restarting containers.

Instead, follow a structured troubleshooting workflow.

```

User Reports Issue

↓

Verify Container Status

↓

Check Logs

↓

Inspect Container

↓

Verify Environment Variables

↓

Check Networking

↓

Verify Volumes

↓

Check Resource Usage

↓

Identify Root Cause

↓

Implement Fix

↓

Validate Application

↓

Monitor

```

Following a systematic approach helps reduce downtime and prevents unnecessary changes.

---

# 1. Container Keeps Restarting

## Symptoms

- Container disappears from `docker ps`
- Status shows **Restarting**
- Application never becomes available
- Continuous restart loop

Example:

```

CONTAINER ID IMAGE STATUS

2bd91af nginx Restarting (1) 4 seconds ago

```

## Possible Root Causes

- Application crash
- Incorrect CMD
- Wrong ENTRYPOINT
- Missing environment variables
- Missing configuration files
- Database dependency unavailable
- Health check failures

## How to Investigate

Start with logs.

```

docker logs <container>

```

Then inspect container metadata.

```

docker inspect <container>

```

Review:

- Exit Code
- Restart Policy
- Environment Variables
- Mounted Volumes

## Resolution

✔ Check application logs

✔ Verify environment variables

✔ Confirm database connectivity

✔ Validate Dockerfile

✔ Rebuild image if necessary

## Production Tip

Never restart repeatedly without checking logs.

Logs provide the actual reason for failure.

---

# 2. Container Exits Immediately

## Symptoms

Container starts successfully but exits within seconds.

Example

```

Exited (0)

```

or

```

Exited (1)

```

## Why This Happens

Docker containers continue running only while the main process is active.

If the main application exits, Docker stops the container.

Common causes include:

- Script completed successfully
- Wrong CMD instruction
- Shell script exits immediately
- Missing foreground process

Incorrect Example

```dockerfile
CMD service nginx start
```

Correct Example

```dockerfile
CMD ["nginx","-g","daemon off;"]
```

## Resolution

Verify:

- Dockerfile
- CMD
- ENTRYPOINT
- Application startup

Always ensure the primary application runs in the foreground.

---

# 3. Port Already Allocated

## Symptoms

Container fails to start.

Example Error

```

Bind for 0.0.0.0:80 failed

Port is already allocated

```

## Root Cause

Another process or Docker container is already using the requested port.

Common examples:

- Existing Docker container
- Apache
- Nginx
- IIS
- Node.js application

## Investigation

List running containers.

```

docker ps

```

Check listening ports.

Linux

```

ss -tulpn

```

or

```

netstat -tulpn

```

## Resolution

Stop conflicting service.

```

docker stop old-container

```

or choose another port.

```

docker run -p 8080:80 nginx

```

## Production Tip

Maintain a documented port allocation strategy across environments.

---

# 4. Image Pull Access Denied

## Symptoms

```

pull access denied

repository does not exist

```

## Possible Causes

- Incorrect image name
- Private registry authentication failure
- Repository permissions
- Typographical error

## Investigation

Login again.

```

docker login

```

Search image.

```

docker search nginx

```

Verify available images.

```

docker images

```

## Resolution

✔ Login again

✔ Verify repository name

✔ Verify credentials

✔ Check registry permissions

---

# 5. No Space Left on Device

## Symptoms

Image build fails.

Containers cannot start.

Docker pull fails.

Example

```

no space left on device

```

## Root Cause

Docker stores:

- Images
- Containers
- Volumes
- Build Cache
- Networks

Over time unused resources consume disk space.

## Investigation

```

docker system df

```

Check:

- Images
- Volumes
- Containers
- Build Cache

## Resolution

Remove unused resources.

```

docker system prune

```

Remove unused images.

```

docker image prune

```

Remove unused volumes.

```

docker volume prune

```

## Production Tip

Schedule periodic Docker cleanup to avoid unexpected storage exhaustion.

---

# Key Takeaways

- Always troubleshoot methodically instead of restarting containers immediately.
- Begin with `docker ps` to understand the current state.
- Use `docker logs` as the primary source for application errors.
- Inspect container metadata with `docker inspect` before making changes.
- Verify networking, volumes, and environment variables before assuming application issues.
- Monitor disk usage regularly to prevent build and deployment failures.
- Document recurring issues and their resolutions to reduce Mean Time to Recovery (MTTR).

In the next document (`commands.md`), you'll learn the most important Docker troubleshooting commands, practical examples, and realistic outputs used by DevOps engineers during production incidents.