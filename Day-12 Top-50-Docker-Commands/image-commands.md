# Docker Image Commands

## Build

```bash
docker build -t myapp:1.0 .
docker build -t myapp:1.0 -f Dockerfile.prod .
docker build --no-cache -t myapp:1.0 .
docker build --build-arg ENV=prod -t myapp:1.0 .
```

- `-t` tags the image `name:tag`
- `-f` specifies a non-default Dockerfile
- `--no-cache` forces a full rebuild, ignoring layer cache
- `--build-arg` passes build-time variables into the Dockerfile

## List & Inspect

```bash
docker images
docker images -a                     # include intermediate images
docker image inspect myapp:1.0
docker image history myapp:1.0       # see each layer and its size
```

Use `docker image history` to spot which instruction bloated your image — very useful when optimizing Dockerfiles (see Day 07 of this series).

## Tag

```bash
docker tag myapp:1.0 123456789012.dkr.ecr.ap-south-1.amazonaws.com/myapp:1.0
```

Tagging doesn't duplicate the image — it just creates another reference to the same image ID.

## Pull / Push

```bash
docker pull nginx:1.25
docker push 123456789012.dkr.ecr.ap-south-1.amazonaws.com/myapp:1.0
```

## Remove

```bash
docker rmi myapp:1.0
docker rmi -f myapp:1.0              # force remove even if containers reference it
docker rmi $(docker images -q -f dangling=true)   # remove all dangling images
```

## Save / Load (offline transfer)

```bash
docker save -o myapp.tar myapp:1.0
docker load -i myapp.tar
```

Useful for air-gapped environments or manually copying an image between hosts without a registry.

## AWS ECR Context

```bash
aws ecr get-login-password --region ap-south-1 | \
  docker login --username AWS --password-stdin 123456789012.dkr.ecr.ap-south-1.amazonaws.com

docker build -t myapp .
docker tag myapp:latest 123456789012.dkr.ecr.ap-south-1.amazonaws.com/myapp:latest
docker push 123456789012.dkr.ecr.ap-south-1.amazonaws.com/myapp:latest
```

This is the standard build-tag-push flow used for EKS deployments.
