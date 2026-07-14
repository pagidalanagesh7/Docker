# Docker Common Errors & Solutions

This document lists common Docker errors encountered in production environments, their root causes, and recommended solutions.

| Error | Possible Root Cause | Resolution |
|-------|----------------------|------------|
| Container Restart Loop | Application crash, wrong CMD, failed health check | Check `docker logs`, verify Dockerfile, inspect container |
| Container Exited Immediately | Main process finished, incorrect CMD | Ensure the main application runs in the foreground |
| Port Already Allocated | Port already used by another process/container | Stop the conflicting process or use another port |
| Image Pull Access Denied | Authentication failure or wrong repository | Run `docker login`, verify repository and permissions |
| No Space Left on Device | Docker images, volumes, or build cache consuming disk | Use `docker system df`, remove unused resources |
| Permission Denied | Incorrect file permissions or ownership | Fix permissions, run as non-root user where appropriate |
| DNS Resolution Failed | Incorrect DNS configuration or network issue | Verify Docker network, test with `nslookup` |
| Database Connection Refused | Database unavailable or wrong hostname | Verify database status, network, and credentials |
| Bind Mount Not Working | Incorrect host path or permissions | Use absolute paths and verify mount permissions |
| Volume Data Missing | Wrong volume mapping or accidental deletion | Inspect volume, restore from backup if required |
| High CPU Usage | Resource-intensive application | Analyze application, optimize code, apply CPU limits |
| High Memory Usage | Memory leak or insufficient limits | Monitor with `docker stats`, increase memory if required |
| HEALTHCHECK Failed | Application not responding | Verify health endpoint and dependencies |
| Network Connectivity Failed | Containers not on the same network | Inspect Docker network and reconnect containers |
| Container Cannot Access Internet | DNS, proxy, or bridge network issue | Verify bridge network, DNS, and firewall rules |
| COPY Failed During Build | Incorrect file path or missing files | Verify Dockerfile paths and build context |
| Build Failed | Dockerfile syntax or dependency issues | Review build logs and correct Dockerfile instructions |
| Exec Format Error | Architecture mismatch or invalid executable | Use the correct image architecture and executable |
| Too Many Open Files | File descriptor limit reached | Increase ulimit and optimize file handling |
| OCI Runtime Error | Runtime configuration issue | Inspect container configuration and Docker daemon logs |

---

# Recommended Troubleshooting Commands

```bash
docker ps
docker ps -a
docker logs <container>
docker inspect <container>
docker exec -it <container> /bin/sh
docker stats
docker network inspect bridge
docker volume inspect <volume>
docker system df
docker system prune
```

---

# Production Troubleshooting Order

1. Check container status.
2. Review application logs.
3. Inspect container configuration.
4. Verify networking.
5. Validate storage.
6. Check CPU and memory usage.
7. Confirm health check status.
8. Identify the root cause.
9. Apply the fix.
10. Validate the application after recovery.

---

# Key Takeaways

- Do not restart containers without collecting logs.
- Focus on identifying the root cause instead of treating symptoms.
- Maintain a documented troubleshooting workflow.
- Use monitoring and health checks to detect issues early.
- Practice troubleshooting in a lab environment before handling production incidents.