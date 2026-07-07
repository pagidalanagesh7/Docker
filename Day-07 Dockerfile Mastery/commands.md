# Dockerfile & Image Optimization - Commands Reference

## Building Images

```bash
# Basic build
docker build -t myapp:1.0 .

# Build with a specific Dockerfile
docker build -f dockerfiles/nodejs/Dockerfile -t myapp-node:1.0 .

# Build with build-time arguments
docker build --build-arg NODE_ENV=production -t myapp:1.0 .

# Build without using cache (force fresh build)
docker build --no-cache -t myapp:1.0 .

# Build a specific stage in a multi-stage Dockerfile
docker build --target builder -t myapp-builder .
```

## Inspecting Image Size & Layers

```bash
# List images with sizes
docker images

# Show detailed image history (layers + size per layer)
docker history myapp:1.0

# Inspect image metadata
docker inspect myapp:1.0

# See layer-by-layer breakdown (human-readable)
docker history --no-trunc myapp:1.0
```

## Analyzing & Reducing Image Size

```bash
# Use dive tool to analyze layers interactively (install separately)
dive myapp:1.0

# Check for unused/dangling images
docker images -f dangling=true

# Remove dangling images
docker image prune

# Remove all unused images (not just dangling)
docker image prune -a
```

## Multi-Stage Build Commands

```bash
# Build only up to a specific stage
docker build --target build-stage -t myapp:build .

# Build final production stage (default, last stage in file)
docker build -t myapp:prod .
```

## Tagging & Pushing to Registry (AWS ECR example)

```bash
# Authenticate Docker to ECR
aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin <account_id>.dkr.ecr.ap-south-1.amazonaws.com

# Tag image for ECR
docker tag myapp:1.0 <account_id>.dkr.ecr.ap-south-1.amazonaws.com/myapp:1.0

# Push to ECR
docker push <account_id>.dkr.ecr.ap-south-1.amazonaws.com/myapp:1.0
```

## Scanning Images for Vulnerabilities

```bash
# Docker Scout (built-in)
docker scout cves myapp:1.0

# Trivy scan
trivy image myapp:1.0

# AWS ECR scan (triggered automatically or manually)
aws ecr start-image-scan --repository-name myapp --image-id imageTag=1.0
```

## Cleaning Up

```bash
# Remove a specific image
docker rmi myapp:1.0

# Remove all stopped containers
docker container prune

# Remove everything unused (images, containers, networks, build cache)
docker system prune -a

# Check disk usage by Docker
docker system df
```

## Running & Testing Optimized Images

```bash
# Run container from built image
docker run -d -p 3000:3000 --name myapp-container myapp:1.0

# Check running container's resource usage
docker stats myapp-container

# Execute shell inside a running container (if shell exists)
docker exec -it myapp-container sh

# View container logs
docker logs -f myapp-container
```

## Comparing Image Sizes (Before vs After Optimization)

```bash
docker build -f Dockerfile.unoptimized -t myapp:unoptimized .
docker build -f Dockerfile.optimized -t myapp:optimized .
docker images | grep myapp
```
