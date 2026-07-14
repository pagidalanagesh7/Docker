# Docker Cleanup Commands

## Containers

```bash
docker container prune                       # remove all stopped containers
docker rm $(docker ps -aq -f status=exited)     # same, manual filter
docker ps -aq | xargs docker rm -f                # force remove everything (dangerous)
```

## Images

```bash
docker image prune                    # remove dangling images only (safe)
docker image prune -a                   # remove ALL unused images (not referenced by any container)
docker images -f dangling=true -q | xargs docker rmi   # manual dangling cleanup
```

## Volumes

```bash
docker volume prune                    # remove volumes not used by any container
docker volume ls -qf dangling=true | xargs docker volume rm
```

⚠️ Always double-check `docker volume ls` before pruning — this deletes data permanently with no undo.

## Networks

```bash
docker network prune                   # remove unused user-defined networks
```

## Everything at Once

```bash
docker system prune -a --volumes
```

This removes:
- all stopped containers
- all networks not used by a container
- all images without a container referencing them
- all unused volumes
- all build cache

## Safe Cleanup Routine (Recommended Order)

```bash
docker container prune -f
docker image prune -f
docker network prune -f
docker volume prune -f            # only if you're sure no needed data lives here
docker builder prune -f            # clear build cache separately
```

## Scheduled Cleanup (cron example)

```bash
# /etc/cron.d/docker-cleanup
0 3 * * * root docker system prune -af --filter "until=168h" >> /var/log/docker-cleanup.log 2>&1
```

`--filter "until=168h"` only removes objects older than 7 days, avoiding accidental removal of images/containers still in active use.

## Production Note

Never run `docker system prune -a --volumes` blindly on a production node via automation without the `until` filter — it can wipe images mid-deploy or delete volumes backing a container that's briefly stopped for a restart.
