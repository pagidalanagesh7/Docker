# Docker Registry - Theory 📖

## What is a Registry?

A **Docker Registry** is a storage and distribution system where Docker images are stored. When you build an image locally with `docker build` and push it to a registry, it can be pulled and run from anywhere in the world — including any node in a cluster.

Put simply:
> Registry = A **GitHub** for images, except instead of storing code, it stores container images.

## Key Terminology

| Term | Meaning |
|---|---|
| **Registry** | The server where images are stored (Docker Hub, ECR, Harbor, GHCR) |
| **Repository** | A collection of different versions (tags) of the same image |
| **Tag** | A specific version identifier (e.g., `v1.0`, `latest`, `3.2.1`) |
| **Image** | The combination of layers + metadata, the actual runnable artifact |
| **Manifest** | The blueprint of an image - layers, config, architecture info |
| **Digest** | SHA256 hash - a unique fingerprint of the image content |

## Registry vs Repository vs Image

```
Registry (docker.io / your-account.dkr.ecr.ap-south-1.amazonaws.com)
   └── Repository (nagesh/watsonx-app)
         ├── Tag: v1.0   → Image A
         ├── Tag: v1.1   → Image B
         └── Tag: latest → Image B (same as v1.1)
```

## Types of Registries

1. **Public Registries**
   - Docker Hub (default registry)
   - GitHub Container Registry (GHCR)
   - Quay.io

2. **Private/Managed Registries**
   - **AWS ECR** (Elastic Container Registry) - commonly used in IBM Watsonx EKS deployments
   - Azure Container Registry (ACR)
   - Google Artifact Registry (GAR)

3. **Self-hosted Registries**
   - Harbor (enterprise-grade, RBAC + vulnerability scanning)
   - Plain `registry:2` (Docker's official registry image)

## Why AWS ECR? (Watsonx/EKS Context)

When our IBM Watsonx platform runs on EKS, we store images in **ECR** because:

- **IAM-based auth**: No separate username/password - authenticated purely through the EKS node's IAM role
- **VPC-native**: Low-latency, private access from the EKS cluster to ECR (possible via VPC endpoints too)
- **Image scanning**: Every pushed image gets an automatic vulnerability scan
- **Lifecycle policies**: Old/unused image tags can be automatically cleaned up (cost saving)
- **Cross-region replication**: Useful for DR (Disaster Recovery)

## How Push/Pull Works (High Level Flow)

```
1. docker build -t myapp:v1 .
2. docker tag myapp:v1 <registry>/myapp:v1
3. docker login <registry>
4. docker push <registry>/myapp:v1
   → Layers upload (already-existing layers are skipped - layer caching)
   → Manifest upload
5. Kubernetes/EKS node:
   docker pull <registry>/myapp:v1 (or containerd pulls it automatically)
```

## Real Incident Reference

Once in IBM Watsonx EKS, we hit an `ImagePullBackOff` error - the reason: the image tag didn't exist in ECR (the CI pipeline had pushed the wrong tag). We'll discuss this as a scenario in [interview-questions.md](./interview-questions.md).

---
➡️ Next: [registry-architecture.md](./registry-architecture.md)
