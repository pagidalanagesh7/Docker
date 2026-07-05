# Docker Networking Commands

## List all Docker networks

```bash
docker network ls
```

---

## Inspect the default bridge network

```bash
docker network inspect bridge
```

---

## Create a user-defined bridge network

```bash
docker network create app-network
```

---

## Run a container on a custom network

```bash
docker run -d \
--name web \
--network app-network \
nginx
```

---

## Create another container

```bash
docker run -dit \
--name app \
--network app-network \
ubuntu
```

---

## Access a running container

```bash
docker exec -it app bash
```

---

## Test communication between containers

```bash
ping web
```

---

## Connect an existing container to a network

```bash
docker network connect app-network nginx
```

---

## Disconnect a container

```bash
docker network disconnect app-network nginx
```

---

## Display port mapping

```bash
docker port web
```

---

## Inspect container networking

```bash
docker inspect web
```

---

## Remove a Docker network

```bash
docker network rm app-network
```

---

## Remove unused Docker networks

```bash
docker network prune
```