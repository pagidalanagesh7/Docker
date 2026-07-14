# Production Tips for Docker Commands

## Do's

- **Always pin image tags** — never run `latest` in production. Use `myapp:1.4.2` or a git SHA tag so rollbacks are deterministic.
- **Set resource limits** on every `docker run` in prod-like environments: `--memory` and `--cpus`, to prevent one container from starving the host.
- **Use `--restart=unless-stopped`** rather than `always` for most services — it respects an intentional `docker stop` and won't fight you during maintenance.
- **Use named volumes**, not anonymous ones, for anything stateful — they're addressable and won't get silently pruned.
- **Enable healthchecks** (`HEALTHCHECK` in Dockerfile or `--health-cmd` on run) so `docker ps` accurately reflects container health, not just process status.
- **Scan images before push**: `docker scout cves myapp:1.0` or rely on ECR scan-on-push.
- **Use `docker logs --tail` with a limit** in scripts/automation — unbounded `docker logs` on a long-running container can flood output.

## Don'ts

- **Don't run `docker system prune -a --volumes` on a live node** without an `until=` filter — it can delete images/volumes mid-deploy.
- **Don't use `docker exec` as your primary debugging workflow in prod** — prefer reading logs/metrics first; shelling into a live container should be a last resort and logged/audited.
- **Don't mount the Docker socket (`-v /var/run/docker.sock:/var/run/docker.sock`)** into arbitrary containers — it's equivalent to giving that container root on the host.
- **Don't rely on `docker stop`'s default 10s grace period** for apps that need longer shutdown (e.g. draining connections) — set `-t <seconds>` explicitly or handle `SIGTERM` promptly in your app.
- **Don't build images with secrets baked into layers** (`ENV`, `COPY .env`) — use build secrets (`--secret`) or inject at runtime.

## Command Habits Worth Building

| Instead of | Prefer | Why |
|---|---|---|
| `docker kill` | `docker stop` | Graceful shutdown, avoids data corruption |
| `docker rm -f` on a live container | `docker stop` then `docker rm` | Understand *why* it needs force-removal first |
| Manual `docker build && docker push` | CI/CD pipeline (Jenkins/GH Actions) | Reproducibility, auditability |
| `latest` tag | Immutable version tag | Predictable rollbacks |
| Ad-hoc `docker run` in prod | `docker compose` or Kubernetes manifest | Declarative, version-controlled |

## Debugging Checklist (Command Order)

1. `docker ps -a` — is it even running?
2. `docker logs --tail 200 <container>` — what does it say?
3. `docker inspect <container>` — check restart count, exit code, mounts, env
4. `docker stats <container>` — resource starvation?
5. `docker exec -it <container> sh` — only if 1–4 didn't answer it
