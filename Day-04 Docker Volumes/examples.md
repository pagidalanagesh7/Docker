# 🧪 Docker Volume Practical Examples

This document contains practical examples demonstrating how Docker Volumes work in real-world scenarios.

---

# Example 1 – Named Volume

Create a Docker Volume.

```bash
docker volume create mysql-data
```

Verify

```bash
docker volume ls
```

Output

```
DRIVER    VOLUME NAME
local     mysql-data
```

---

# Example 2 – MySQL with Persistent Storage

Run MySQL using a Docker Volume.

```bash
docker run -d \
--name mysql-db \
-e MYSQL_ROOT_PASSWORD=root123 \
-v mysql-data:/var/lib/mysql \
mysql:latest
```

Output

```
Container Started Successfully
```

Delete the container.

```bash
docker rm -f mysql-db
```

Run a new container using the same volume.

```bash
docker run -d \
--name mysql-db-new \
-e MYSQL_ROOT_PASSWORD=root123 \
-v mysql-data:/var/lib/mysql \
mysql:latest
```

Result

```
Database files still exist.

Data Persisted ✅
```

---

# Example 3 – Bind Mount

Project Structure

```
project/

index.html
```

Run

```bash
docker run -d \
-p 8080:80 \
-v $(pwd):/usr/share/nginx/html \
nginx
```

Open Browser

```
http://localhost:8080
```

Modify

```
index.html
```

Refresh browser.

Result

```
Changes appear immediately.

No rebuild required.
```

---

# Example 4 – tmpfs Mount

```bash
docker run -it \
--tmpfs /tmp \
ubuntu
```

Inside container

```bash
cd /tmp

touch demo.txt

ls
```

Output

```
demo.txt
```

Stop container.

Run again.

```
demo.txt

No longer exists.
```

Reason

tmpfs stores data only in RAM.

---

# Example 5 – Backup a Volume

```bash
docker run --rm \
-v mysql-data:/source \
-v $(pwd):/backup \
ubuntu \
tar czf /backup/mysql-backup.tar.gz /source
```

Output

```
mysql-backup.tar.gz
```

Backup completed successfully.

---

# Example 6 – Restore a Volume

```bash
docker run --rm \
-v mysql-data:/restore \
-v $(pwd):/backup \
ubuntu \
tar xzf /backup/mysql-backup.tar.gz -C /
```

Result

```
Database restored successfully.
```

---

# Example 7 – Compare Storage Types

| Storage Type | Best For |
|--------------|----------|
| Docker Volume | Databases & Production |
| Bind Mount | Development |
| tmpfs | Temporary Files, Cache, Secrets |

---

# Real-World Scenario

Imagine an E-commerce application.

```
Customer

     │

Application

     │

Docker Container

     │

Docker Volume

     │

Physical Disk
```

If the application container crashes,

```
Container Deleted
```

Start another container using the same volume.

```
Customer Orders
Still Available ✅
```

This is why Docker Volumes are widely used in production environments.

---

# Conclusion

Docker Volumes provide persistent storage that survives container deletion.

Bind Mounts are best suited for development.

tmpfs is ideal for temporary or sensitive data stored in memory.