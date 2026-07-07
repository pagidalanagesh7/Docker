# Dockerfile & Image Optimization - Theory

## 1. What is a Dockerfile?
A Dockerfile is a text file containing a set of instructions used by Docker to build an image automatically. Each instruction creates a **layer** in the image.

```
Instruction → Layer
FROM        → Base layer
RUN         → New layer with command output
COPY/ADD    → New layer with files
```

## 2. Why Image Optimization Matters
- **Faster deployments** — smaller images pull/push quicker in CI/CD pipelines
- **Reduced attack surface** — fewer packages = fewer vulnerabilities
- **Lower storage/bandwidth costs** — especially important at scale (ECR, registries)
- **Faster autoscaling** — smaller images mean faster pod startup in EKS/Kubernetes

## 3. Core Dockerfile Instructions

| Instruction | Purpose |
|---|---|
| `FROM` | Defines the base image |
| `WORKDIR` | Sets the working directory inside container |
| `COPY` | Copies files from host to image |
| `ADD` | Like COPY, but supports URL/tar extraction (use COPY unless you need this) |
| `RUN` | Executes commands during image build |
| `CMD` | Default command when container starts |
| `ENTRYPOINT` | Fixed executable for the container |
| `EXPOSE` | Documents the port the app listens on |
| `ENV` | Sets environment variables |
| `ARG` | Build-time variables |
| `USER` | Sets non-root user for security |
| `HEALTHCHECK` | Defines container health check command |

## 4. Image Layers & Caching
Docker builds images layer-by-layer, and **caches each layer**. If a layer hasn't changed, Docker reuses the cache instead of rebuilding it.

**Key rule:** Order instructions from **least frequently changed** to **most frequently changed**.

```dockerfile
# Good ordering (dependencies before app code)
COPY package.json .
RUN npm install
COPY . .
```

If you copy the entire app code first, then run `npm install`, every code change invalidates the cache and forces a full dependency reinstall.

## 5. Multi-Stage Builds
Multi-stage builds let you use one image to **build/compile** an application and a separate, smaller image to **run** it — discarding build tools, source code, and intermediate files from the final image.

```dockerfile
# Stage 1: Build
FROM node:20 AS builder
WORKDIR /app
COPY . .
RUN npm install && npm run build

# Stage 2: Run
FROM node:20-alpine
WORKDIR /app
COPY --from=builder /app/dist ./dist
CMD ["node", "dist/index.js"]
```

Benefits:
- Final image doesn't contain compilers, build tools, dev dependencies
- Drastically reduces image size (often by 70-90%)

## 6. Choosing the Right Base Image

| Base Image Type | Size | Use Case |
|---|---|---|
| `ubuntu`/`debian` | ~70-120MB | Full OS tools needed |
| `slim` variants | ~40-60MB | Reduced OS packages |
| `alpine` | ~5-10MB | Minimal, musl-based libc (watch for compatibility issues) |
| `distroless` | ~2-20MB | No shell, no package manager — most secure, minimal attack surface |
| `scratch` | 0MB | Empty base, for statically compiled binaries (e.g., Go) |

## 7. .dockerignore
Just like `.gitignore`, this file excludes files/folders from the Docker **build context**, reducing build time and preventing accidental inclusion of secrets, `node_modules`, `.git`, logs, etc.

```
node_modules
.git
*.log
.env
Dockerfile
```

## 8. Reducing Layers
Combine related `RUN` commands using `&&` and clean up in the same layer to avoid leaving cached package manager files in intermediate layers.

```dockerfile
RUN apt-get update && \
    apt-get install -y curl && \
    rm -rf /var/lib/apt/lists/*
```

## 9. Security Considerations
- Avoid running containers as `root` — use `USER appuser`
- Use specific image tags (avoid `latest`) for reproducibility
- Scan images with tools like `trivy`, `docker scout`, or AWS ECR image scanning
- Don't bake secrets into images — use environment variables, AWS Secrets Manager, or mounted secrets at runtime

## 10. Image Optimization in an AWS/EKS Context
- Smaller images → faster EKS pod scheduling and autoscaling
- Push optimized images to **Amazon ECR** to reduce storage costs and speed up CI/CD (CodeBuild/Jenkins/GitHub Actions)
- Use ECR **image scanning** to catch vulnerabilities before deployment
- Combine with **Karpenter/Cluster Autoscaler** for faster node bring-up since smaller images pull faster on new EC2 nodes
