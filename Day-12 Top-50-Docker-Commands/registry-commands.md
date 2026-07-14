# Docker Registry Commands (AWS ECR Focus)

## Docker Hub

```bash
docker login
docker login -u <username>
docker logout
```

## AWS ECR

```bash
# Authenticate Docker to ECR
aws ecr get-login-password --region ap-south-1 | \
  docker login --username AWS --password-stdin 123456789012.dkr.ecr.ap-south-1.amazonaws.com

# Create a repository (one-time)
aws ecr create-repository --repository-name myapp --region ap-south-1

# Tag local image for ECR
docker tag myapp:latest 123456789012.dkr.ecr.ap-south-1.amazonaws.com/myapp:latest

# Push
docker push 123456789012.dkr.ecr.ap-south-1.amazonaws.com/myapp:latest

# Pull (e.g. on an EC2 node or EKS worker)
docker pull 123456789012.dkr.ecr.ap-south-1.amazonaws.com/myapp:latest
```

## List Images in a Repo

```bash
aws ecr list-images --repository-name myapp --region ap-south-1
aws ecr describe-images --repository-name myapp --region ap-south-1
```

## Delete an Image from ECR

```bash
aws ecr batch-delete-image \
  --repository-name myapp \
  --image-ids imageTag=old-tag \
  --region ap-south-1
```

## CI/CD Context (Jenkins/GitHub Actions)

Typical pipeline stage:

```bash
aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin $ECR_REGISTRY
docker build -t $ECR_REGISTRY/$ECR_REPO:$BUILD_NUMBER .
docker push $ECR_REGISTRY/$ECR_REPO:$BUILD_NUMBER
```

The auth token from `get-login-password` is valid for **12 hours** — re-authenticate in every pipeline run rather than caching it.

## Production Note

Enable **image scanning on push** in ECR (`--image-scanning-configuration scanOnPush=true`) to catch vulnerable base images before they hit EKS. Also set **lifecycle policies** to auto-expire old untagged images and avoid storage cost creep.
