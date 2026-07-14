# Real-Time Scenarios — Docker Commands in Action

## Scenario 1: App container exits immediately after `docker run`

```bash
docker ps -a                          # confirm STATUS shows "Exited (1)"
docker logs <container>                 # see the actual error/stack trace
docker inspect <container> --format '{{.State.ExitCode}}'
```
Common causes: missing env var, app crashing on startup, wrong `CMD`/`ENTRYPOINT`, port already bound.

## Scenario 2: Container is running but the app inside isn't reachable

```bash
docker ps                             # confirm the port mapping, e.g. 0.0.0.0:8080->80/tcp
docker port <container>                 # explicit port mapping check
docker exec -it <container> curl localhost:80    # is the app actually listening inside?
docker inspect <container> --format '{{.NetworkSettings.IPAddress}}'
```
If it works inside the container but not from the host, the issue is usually the port mapping or a host firewall/security group (check EC2 security groups for AWS-hosted nodes).

## Scenario 3: Node running out of disk, containers failing to start

```bash
docker system df -v
docker image prune -a --filter "until=168h"
docker builder prune
df -h                                  # confirm at OS level too
```
Kubernetes will taint a node `DiskPressure` under this condition — clean up before pods get evicted.

## Scenario 4: Need to debug a container that's CrashLoopBackOff in Kubernetes, but want to reproduce locally with plain Docker

```bash
docker run -it --rm <image> sh          # drop into shell instead of default CMD
docker run --entrypoint sh -it <image>    # override entrypoint entirely
```
Running with `--rm` and an interactive shell, bypassing the normal command, is the fastest way to poke at the filesystem and confirm a config/permissions issue outside of Kubernetes' restart loop.

## Scenario 5: Two containers can't talk to each other

```bash
docker network ls
docker inspect <container1> --format '{{.NetworkSettings.Networks}}'
docker network create appnet
docker network connect appnet <container1>
docker network connect appnet <container2>
```
Verify with `docker exec -it <container1> ping <container2-name>`.

## Scenario 6: Accidentally left a container running with a bind mount to a critical host directory

```bash
docker inspect <container> --format '{{json .Mounts}}'
docker stop <container>
```
Always audit `.Mounts` before assuming a container is "just a container" — bind mounts to `/`, `/etc`, or `/var/run/docker.sock` are a red flag in any security review.

## Scenario 7: Registry push fails with "no basic auth credentials"

```bash
aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin <registry-url>
docker push <registry-url>/myapp:latest
```
ECR auth tokens expire after 12 hours — this is the most common cause in CI pipelines that cache credentials too long.

## Scenario 8: Need to quickly check what changed inside a container vs its base image

```bash
docker diff <container>
```
Output prefixes: `A` = added, `C` = changed, `D` = deleted. Useful when investigating whether a container was tampered with or to understand what a running process wrote to disk (logs, temp files, etc.) before deciding what needs a volume.
