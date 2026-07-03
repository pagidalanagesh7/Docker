# 🐳 Practical Examples

## Example 1 — Pull an Image

```bash
docker pull nginx
```

Verify:

```bash
docker images
```

---

## Example 2 — Run a Container

```bash
docker run -d -p 8080:80 nginx
```

Open:

```

http://localhost:8080

```

---

## Example 3 — Build Your Own Image

Dockerfile

```dockerfile
FROM ubuntu:24.04

RUN apt update

CMD ["echo", "Hello Docker!"]
```

Build

```bash
docker build -t hello-docker:v1 .
```

Run

```bash
docker run hello-docker:v1
```

---

## Example 4 — Tag an Image

```bash
docker tag hello-docker:v1 username/hello-docker:v1
```

---

## Example 5 — Push to Docker Hub

```bash
docker login

docker push username/hello-docker:v1
```

---

## Example 6 — Save an Image

```bash
docker save hello-docker:v1 > hello-docker.tar
```

---

## Example 7 — Load an Image

```bash
docker load < hello-docker.tar
```

---

## Example 8 — Remove an Image

```bash
docker rmi hello-docker:v1
```