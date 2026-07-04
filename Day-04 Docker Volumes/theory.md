# 📖 Docker Theory – Day 4: Docker Volumes & Data Persistence

## 📌 Introduction

By default, Docker containers are **ephemeral**, meaning the data inside a container is temporary.

If a container is stopped, removed, or recreated, any data stored inside the container's writable layer will be lost.

This is where **Docker Volumes** come into the picture.

Docker Volumes provide persistent storage that exists outside the lifecycle of a container.

---

# Why Do We Need Docker Volumes?

Imagine you are running a MySQL database inside a Docker container.

```
Container
    │
 Database Files
```

Now suppose you remove the container.

```bash
docker rm mysql-container
```

The container is deleted.

Unfortunately, the database files stored inside the container are also deleted.

```
Container Deleted
        │
Database Lost ❌
```

This is a serious problem because production applications cannot lose customer data.

To solve this problem, Docker introduced **Volumes**.

---

# What is a Docker Volume?

A Docker Volume is a Docker-managed storage location used to persist application data.

Unlike container storage, volumes continue to exist even after containers are removed.

```
Container
      │
      ▼
 Docker Volume
      │
      ▼
 Physical Storage
```

The same volume can be attached to multiple containers.

---

# Benefits of Docker Volumes

Docker Volumes provide several advantages.

- Persistent storage
- Better performance
- Easy backup & restore
- Share data between containers
- Docker manages storage automatically
- Recommended for production databases

---

# Types of Docker Storage

Docker mainly provides three storage options.

1. Docker Volumes
2. Bind Mounts
3. tmpfs Mounts

Let's understand each one.

---

# Docker Volumes

Docker Volumes are managed completely by Docker.

Docker creates and stores them in its own storage directory.

Example:

```bash
docker volume create mysql-data
```

Verify:

```bash
docker volume ls
```

Output

```
DRIVER    VOLUME NAME
local     mysql-data
```

Use the volume:

```bash
docker run -d \
--name mysql-db \
-v mysql-data:/var/lib/mysql \
mysql
```

Explanation

- mysql-data → Docker Volume
- /var/lib/mysql → Database storage directory inside container

Even if the container is deleted, the database remains inside the volume.

---

# Named Volumes

Named volumes have a custom name.

Example

```bash
docker volume create app-data
```

Advantages

- Easy to identify
- Easy backup
- Easy restore
- Recommended for production

---

# Anonymous Volumes

Anonymous volumes are automatically created by Docker.

Example

```bash
docker run -v /var/lib/mysql mysql
```

Docker automatically generates a random volume name.

Example

```
8f32a9ab6ce0...
```

Disadvantages

- Hard to identify
- Difficult to manage
- Mostly used for temporary workloads

---

# Bind Mounts

Bind Mounts connect a directory from the host machine directly into the container.

```
Host Machine
      │
      ▼
 Project Folder
      │
      ▼
 Container
```

Example

```bash
docker run \
-v $(pwd):/app \
nginx
```

Explanation

Current folder from the host machine is mounted inside the container at `/app`.

Any changes made on the host are immediately visible inside the container.

Perfect for development.

---

# When Should We Use Bind Mounts?

Use Bind Mounts when

- Developing applications
- Editing source code
- Testing applications
- Live code synchronization

Not recommended for production databases.

---

# tmpfs Mounts

tmpfs stores files in RAM instead of disk.

```
RAM
 │
 ▼
tmpfs
 │
 ▼
Container
```

Example

```bash
docker run \
--tmpfs /tmp \
nginx
```

Benefits

- Very fast
- No disk usage
- Automatically deleted when container stops

Common use cases

- Cache
- Temporary files
- Sensitive data

---

# Volume vs Bind Mount vs tmpfs

| Feature | Volume | Bind Mount | tmpfs |
|----------|--------|------------|--------|
| Docker Managed | ✅ | ❌ | ❌ |
| Host Access | ❌ | ✅ | ❌ |
| Persistent | ✅ | ✅ | ❌ |
| Stored in RAM | ❌ | ❌ | ✅ |
| Production | ⭐⭐⭐⭐⭐ | ⭐⭐ | ⭐⭐⭐ |

---

# Docker Volume Lifecycle

```
Create Volume
      │
      ▼
Attach Volume
      │
      ▼
Store Data
      │
      ▼
Delete Container
      │
      ▼
Volume Still Exists
      │
      ▼
Attach to New Container
```

This is called **Data Persistence**.

---

# Real World Example

Suppose an e-commerce company stores customer orders in MySQL.

```
Customer

     │

Application

     │

Docker Container

     │

Docker Volume

     │

Disk
```

If the application container crashes,

```
Container Deleted
```

A new container can be started using the same Docker Volume.

Result

```
Customer Data
Still Available ✅
```

This is why almost every production database uses Docker Volumes.

---

# Best Practices

- Use Named Volumes for databases.
- Use Bind Mounts during development.
- Use tmpfs for temporary or sensitive files.
- Backup Docker Volumes regularly.
- Remove unused volumes using `docker volume prune`.
- Never store production databases inside container writable storage.

---

# Summary

Docker Volumes solve one of the biggest problems in containers—**data loss**.

By storing data outside the container, applications can be updated, restarted, or recreated without losing important information.

Understanding Docker storage is essential before moving to Docker Networking and Docker Compose.