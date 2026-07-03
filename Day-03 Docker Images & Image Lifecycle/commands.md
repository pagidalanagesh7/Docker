# 🐳 Docker Image Commands

## List Images

```bash
docker images
```

Displays all locally available Docker images.

---

## Pull an Image

```bash
docker pull nginx
```

Downloads an image from Docker Hub.

---

## Build an Image

```bash
docker build -t myapp:v1 .
```

Builds an image using the Dockerfile.

---

## Tag an Image

```bash
docker tag myapp:v1 username/myapp:v1
```

Creates a new tag for an image.

---

## Push an Image

```bash
docker push username/myapp:v1
```

Uploads an image to Docker Hub.

---

## Remove an Image

```bash
docker rmi IMAGE_ID
```

Deletes an image from the local system.

---

## Save an Image

```bash
docker save myapp > myapp.tar
```

Exports an image into a tar archive.

---

## Load an Image

```bash
docker load < myapp.tar
```

Imports an image from a tar archive.