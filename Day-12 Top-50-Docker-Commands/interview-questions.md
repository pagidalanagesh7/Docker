# Docker Commands — Scenario-Based Interview Questions

**Q1. A container keeps restarting in a loop. Walk through the commands you'd use to debug it.**
Start with `docker ps -a` to confirm the restart count and exit code. Then `docker logs --tail 200 <container>` for the crash reason. `docker inspect <container>` shows the exact `ExitCode` and `OOMKilled` flag — if `OOMKilled: true`, it's a memory limit issue, fixable via `--memory` tuning or app-level leak investigation. If it's a config/env issue, `docker inspect` also shows the resolved environment variables and mounts.

**Q2. Your EKS/EC2 node has run out of disk space. Which Docker commands help you diagnose and fix this without breaking running workloads?**
`docker system df -v` to see what's consuming space (images vs containers vs volumes vs build cache). Then targeted cleanup: `docker image prune -a --filter "until=168h"` to remove images older than a week rather than a blind `-a` prune, which could remove images about to be used by an in-flight deploy. Build cache is often the biggest hidden consumer — `docker builder prune` separately.

**Q3. What's the difference between `docker stop` and `docker kill`, and when would you use each?**
`docker stop` sends `SIGTERM`, waits a grace period (default 10s, configurable with `-t`), then `SIGKILL`s if the process hasn't exited — giving the app a chance to shut down cleanly (flush buffers, close DB connections). `docker kill` sends `SIGKILL` immediately. Use `stop` in all normal operations; `kill` only when a container is unresponsive and you need it gone now.

**Q4. How do you copy a config file into a running container without rebuilding the image?**
`docker cp ./config.yaml <container>:/etc/app/config.yaml`. Note this doesn't persist across container recreation — for anything long-term, the file should be baked into the image or mounted as a volume/bind mount instead.

**Q5. You need to give two containers the ability to talk to each other by name. What's the setup?**
Create a user-defined bridge network (`docker network create appnet`) and run both containers with `--network appnet`. Docker's embedded DNS then resolves container names to their internal IPs automatically. The default `bridge` network does **not** provide this — a common interview trap.

**Q6. How would you find out which Dockerfile instruction is responsible for a bloated image?**
`docker image history <image>` — it lists every layer with its size, letting you pinpoint the offending `RUN`/`COPY` instruction. Combine with multi-stage builds and `.dockerignore` to fix it (see Day 07 of this series).

**Q7. A teammate accidentally ran `docker volume prune` on a shared dev server. How do you assess the damage and prevent recurrence?**
Immediately check `docker volume ls` and cross-reference against `docker ps -a --filter volume=<name>` to see what's actually gone versus what containers still reference (still-referenced volumes are never pruned). For prevention: never run prune commands ad hoc on shared hosts — wrap them in a reviewed script with an `until=` filter, and back up any volume holding non-reproducible data.

**Q8. How do you push a locally built image to AWS ECR, step by step?**
Authenticate with `aws ecr get-login-password | docker login --username AWS --password-stdin <registry-url>`, tag the local image to match the ECR repo URI (`docker tag myapp:latest <registry-url>/myapp:latest`), then `docker push <registry-url>/myapp:latest`. The auth token is valid 12 hours, so CI pipelines re-authenticate every run rather than caching it.

**Q9. What's the risk of mounting the Docker socket into a container, and when is it actually justified?**
Mounting `/var/run/docker.sock` gives that container the ability to control the host's Docker daemon — effectively root-equivalent access to the host. It's sometimes justified for CI runners or monitoring tools (like cAdvisor) that legitimately need to introspect other containers, but it should never be done for arbitrary application containers, and even then should be scoped with care (read-only where possible, restricted via a proxy like `docker-socket-proxy`).

**Q10. How do you scale a service to 3 replicas locally using Compose, and why might this differ from how you'd do it in Kubernetes?**
`docker compose up -d --scale api=3`. Compose scaling is single-host and doesn't handle load balancing, health-aware routing, or cross-node scheduling — Kubernetes replicas via a Deployment handle all of that plus rolling updates and self-healing. Compose scaling is fine for local testing, not a substitute for orchestration in production.
