# Docker System Commands

## Info & Version

```bash
docker version           # client + server (daemon) version
docker info               # detailed system-wide info: storage driver, containers, images, resources
```

`docker info` is your first stop when the daemon behaves oddly — it shows storage driver, cgroup driver, number of running/stopped containers, and total images.

## Disk Usage

```bash
docker system df           # summary: images, containers, volumes, build cache
docker system df -v          # verbose, per-object breakdown
```

Example output:

```
TYPE            TOTAL     ACTIVE    SIZE      RECLAIMABLE
Images          12        4         3.2GB     1.8GB (56%)
Containers      6         2         120MB     80MB (66%)
Local Volumes   5         3         900MB     300MB (33%)
Build Cache     42        0         1.1GB     1.1GB (100%)
```

## Events (real-time daemon activity stream)

```bash
docker events                          # live stream of daemon events
docker events --filter event=die         # only container-death events
docker events --since 1h                  # events from last hour
```

Useful for correlating a container crash with exactly when it happened during an incident.

## Full System Prune

```bash
docker system prune               # remove stopped containers, dangling images, unused networks
docker system prune -a              # also remove ALL unused images, not just dangling
docker system prune -a --volumes      # also remove unused volumes (careful!)
```

## Production Note

Run `docker system df` as part of routine node health checks on EC2/EKS worker nodes — disk pressure from unpruned images is one of the most common causes of node `DiskPressure` taints in Kubernetes.
