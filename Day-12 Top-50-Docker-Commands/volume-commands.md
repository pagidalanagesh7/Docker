# Docker Volume Commands

## Create & List

```bash
docker volume create appdata
docker volume ls
docker volume inspect appdata
docker volume rm appdata
docker volume prune                # remove all unused volumes
```

## Using Volumes

```bash
# Named volume (Docker-managed storage)
docker run -d -v appdata:/var/lib/app myapp

# Bind mount (host path)
docker run -d -v /home/nagesh/data:/var/lib/app myapp

# Anonymous volume
docker run -d -v /var/lib/app myapp

# Read-only mount
docker run -d -v appdata:/var/lib/app:ro myapp
```

**Named volumes** are managed by Docker (`/var/lib/docker/volumes/...`) and are the recommended approach for production — portable, easy to back up, decoupled from host filesystem layout.

**Bind mounts** map a specific host path — useful for local dev when you want live file sync (e.g. mounting source code).

## Backup a Volume

```bash
docker run --rm -v appdata:/data -v $(pwd):/backup \
  alpine tar czf /backup/appdata-backup.tar.gz -C /data .
```

## Restore a Volume

```bash
docker run --rm -v appdata:/data -v $(pwd):/backup \
  alpine tar xzf /backup/appdata-backup.tar.gz -C /data
```

## Inspect Volume Usage

```bash
docker system df -v          # shows size and container usage per volume
```

## Production Note

Never rely on anonymous volumes for stateful data — they're easy to accidentally prune. Always use named volumes with clear naming conventions (e.g. `<app>-<env>-data`), and back them up on a schedule if they hold anything critical.
