# 🖥️ Docker Volume Commands

This document contains the most commonly used Docker Volume commands with explanations and sample outputs.

---

# 1. Create a Volume

```bash
docker volume create my-volume
```

Output

```
my-volume
```

Creates a new Docker-managed volume.

---

# 2. List All Volumes

```bash
docker volume ls
```

Output

```
DRIVER    VOLUME NAME
local     my-volume
local     mysql-data
```

Displays all Docker volumes available on the host.

---

# 3. Inspect a Volume

```bash
docker volume inspect my-volume
```

Output

```json
[
  {
    "Driver": "local",
    "Mountpoint": "/var/lib/docker/volumes/my-volume/_data"
  }
]
```

Shows detailed information about the volume.

---

# 4. Remove a Volume

```bash
docker volume rm my-volume
```

Output

```
my-volume
```

Deletes the specified Docker volume.

---

# 5. Remove Unused Volumes

```bash
docker volume prune
```

Output

```
Deleted Volumes:
my-volume

Total reclaimed space: 20MB
```

Removes all unused Docker volumes.

---

# 6. Mount a Volume

```bash
docker run -d \
--name nginx-container \
-v my-volume:/usr/share/nginx/html \
nginx
```

Explanation

```
my-volume → Docker Volume
/usr/share/nginx/html → Container Directory
```

---

# 7. Create a Bind Mount

Linux/macOS

```bash
docker run -d \
-v $(pwd):/app \
nginx
```

Windows

```powershell
docker run -d `
-v C:\Project:/app `
nginx
```

Host files are directly shared with the container.

---

# 8. Create a tmpfs Mount

```bash
docker run -d \
--tmpfs /tmp \
nginx
```

Creates temporary storage in RAM.

---

# 9. Backup a Docker Volume

```bash
docker run --rm \
-v my-volume:/source \
-v $(pwd):/backup \
ubuntu \
tar czf /backup/backup.tar.gz /source
```

Output

```
backup.tar.gz created successfully
```

---

# 10. Restore a Docker Volume

```bash
docker run --rm \
-v my-volume:/restore \
-v $(pwd):/backup \
ubuntu \
tar xzf /backup/backup.tar.gz -C /
```

Restores data into the Docker Volume.

---

# 11. Check Running Containers

```bash
docker ps
```

Lists all running containers.

---

# 12. Stop a Container

```bash
docker stop nginx-container
```

Stops the running container.

---

# 13. Remove a Container

```bash
docker rm nginx-container
```

Deletes the container while keeping the volume intact.

---

# Summary

These commands help you create, inspect, manage, back up, restore, and remove Docker Volumes used by containers.