# Docker Production Troubleshooting Checklist

## Introduction

When a Docker issue occurs in production, avoid making immediate changes without investigation. Follow a structured troubleshooting process to identify the root cause quickly and reduce downtime.

This checklist can be used during production incidents.

---

# Step 1: Verify Container Status

- [ ] Check whether the container is running.

```bash
docker ps
```

If the container is not running:

```bash
docker ps -a
```

Check:

- Container Status
- Exit Code
- Restart Count

---

# Step 2: Review Container Logs

```bash
docker logs <container>
```

Look for:

- Application Exceptions
- Startup Errors
- Missing Files
- Missing Environment Variables
- Database Connection Errors

---

# Step 3: Inspect Container Configuration

```bash
docker inspect <container>
```

Verify:

- Environment Variables
- Restart Policy
- Mount Points
- Health Status
- IP Address
- Network Configuration

---

# Step 4: Verify Docker Networking

List available networks.

```bash
docker network ls
```

Inspect network.

```bash
docker network inspect bridge
```

Validate:

- Container IP
- Gateway
- DNS
- Connected Containers

---

# Step 5: Verify Persistent Storage

List Docker volumes.

```bash
docker volume ls
```

Inspect a volume.

```bash
docker volume inspect <volume-name>
```

Verify:

- Mount Path
- Volume Driver
- Data Availability

---

# Step 6: Check Resource Utilization

```bash
docker stats
```

Review:

- CPU Usage
- Memory Usage
- Network I/O
- Block I/O

If usage is high:

- Investigate application
- Review traffic
- Scale if required

---

# Step 7: Verify Port Mapping

```bash
docker port <container>
```

Confirm:

- Correct Host Port
- Correct Container Port

If required:

```bash
ss -tulpn
```

or

```bash
netstat -tulpn
```

---

# Step 8: Verify DNS Resolution

```bash
docker exec -it <container> nslookup google.com
```

Also verify:

```bash
cat /etc/resolv.conf
```

---

# Step 9: Verify Running Processes

```bash
docker exec -it <container> ps -ef
```

Confirm:

- Main Process Running
- No Zombie Processes

---

# Step 10: Verify Disk Usage

```bash
docker system df
```

If storage is exhausted:

```bash
docker image prune
```

```bash
docker system prune
```

> ⚠️ Never prune resources on production without understanding the impact.

---

# Step 11: Verify Health Check

```bash
docker inspect <container>
```

Look for:

```
Health:
Status: healthy
```

If unhealthy:

- Verify endpoint
- Check dependencies
- Review application logs

---

# Step 12: Identify Root Cause

Before applying a fix, ask:

- Is it an application issue?
- Is it a Docker issue?
- Is it a network issue?
- Is it a storage issue?
- Is it a configuration issue?

Always identify the root cause before restarting containers.

---

# Step 13: Apply Resolution

Possible actions:

- Fix Dockerfile
- Update Environment Variables
- Correct Network Configuration
- Restore Volume
- Restart Service
- Redeploy Container

---

# Step 14: Validate the Fix

Verify:

- Container is Running
- Application is Accessible
- Health Check is Healthy
- Logs are Clean
- No Restart Loop
- Resource Usage is Normal

---

# Step 15: Post-Incident Review

Document:

- Root Cause
- Resolution
- Commands Used
- Lessons Learned
- Preventive Measures

---

# Production Best Practices

✔ Follow a structured troubleshooting workflow.

✔ Never restart containers without reviewing logs.

✔ Monitor CPU, Memory, Disk, and Network.

✔ Use HEALTHCHECK in production.

✔ Use centralized logging.

✔ Keep Docker updated.

✔ Maintain regular backups of persistent volumes.

✔ Record recurring issues to reduce Mean Time to Recovery (MTTR).

---

# Final Checklist

✅ Container Running

✅ Logs Reviewed

✅ Container Inspected

✅ Network Verified

✅ Volumes Verified

✅ CPU & Memory Checked

✅ Health Check Passed

✅ Root Cause Identified

✅ Resolution Applied

✅ Application Validated

✅ Documentation Updated