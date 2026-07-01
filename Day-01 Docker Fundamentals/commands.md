# 🧪 Docker Day 1 - Hands-on

## Dockerfile

```dockerfile
FROM ubuntu:24.04

CMD ["echo", "Hello Docker! 🐳"]
```

---

## Build Docker Image

```bash
docker build -t hello-docker .
```

Output

```text
Successfully built xxxxxxxxx
Successfully tagged hello-docker:latest
```

---

## Run Docker Container

```bash
docker run hello-docker
```

Output

```text
Hello Docker! 🐳
```

---

## Explanation

### FROM

```dockerfile
FROM ubuntu:24.04
```

Uses the official Ubuntu 24.04 image as the base.

### CMD

```dockerfile
CMD ["echo", "Hello Docker! 🐳"]
```

Runs the command when the container starts.

---

## Workflow

```text
Dockerfile
      │
      ▼
docker build
      │
      ▼
Docker Image
      │
docker run
      │
      ▼
Docker Container
      │
      ▼
Hello Docker! 🐳
```