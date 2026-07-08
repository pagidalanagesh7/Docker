# Docker Registry - Internal Architecture 🏗️

## Image Anatomy - Layers + Manifest

A Docker image isn't a single blob - it's a collection of:

1. **Layers (Blobs)** - Each Dockerfile instruction (RUN, COPY, ADD) creates a layer. Layers are **immutable** and **content-addressable** (SHA256 hash based).
2. **Manifest** - A JSON file containing the list of layers, their order, and a reference to the config.
3. **Config** - Image metadata: entrypoint, env vars, exposed ports, architecture (amd64/arm64).

```
Manifest
  ├── Config blob (JSON: entrypoint, cmd, env)
  ├── Layer 1 (base OS - e.g., alpine)
  ├── Layer 2 (RUN apt install...)
  ├── Layer 3 (COPY app code)
  └── Layer 4 (final CMD layer)
```

## Content-Addressable Storage

Every layer/blob has a **SHA256 digest**. This is content-based - same content means same hash, different content means different hash.

```
sha256:a3f5e8d9c2b1... → base layer
sha256:7b2c4d1e9f8a... → app code layer
```

Why does this matter?
- **Deduplication**: If the same base image (e.g., `alpine:3.18`) is used by multiple apps, that layer is stored only once
- **Integrity verification**: If there's a hash mismatch during pull, you know the image is corrupted

## Manifest List (Multi-Architecture Support)

Modern registries support **manifest lists** (or OCI Image Index) - this is essentially a "manifest of manifests":

```
myapp:v1 (manifest list)
   ├── linux/amd64 → manifest → layers
   ├── linux/arm64 → manifest → layers
   └── linux/arm/v7 → manifest → layers
```

When you run `docker pull myapp:v1`, the Docker daemon automatically selects the correct architecture manifest (arm64 for M1 Mac, amd64 for an x86 EC2 instance).

## Registry API Flow (Docker Registry HTTP API V2)

```
1. Client → Registry: GET /v2/                          (check API version)
2. Client → Registry: GET /v2/<repo>/manifests/<tag>     (fetch manifest)
3. Client → Registry: GET /v2/<repo>/blobs/<digest>       (fetch each layer)
4. Client: Layers assembled + extracted locally
```

Push time:
```
1. Client → Registry: POST /v2/<repo>/blobs/uploads/     (initiate upload)
2. Client → Registry: PATCH/PUT blob data (chunked)
3. Client → Registry: PUT /v2/<repo>/manifests/<tag>      (final manifest push)
```

## AWS ECR Specific Architecture Notes

- ECR uses S3 as the backend to store image layers (managed by AWS, not directly accessible)
- Metadata (tags, digests, scan results) lives in an internal DynamoDB-like store
- **Authentication**: `aws ecr get-login-password` → temporary token (valid 12 hours) → used for `docker login`
- **VPC Endpoints**: EKS nodes can access ECR privately (no internet gateway needed) via `com.amazonaws.<region>.ecr.api` and `.ecr.dkr` endpoints

## Layer Caching in CI/CD (Relevant to our Jenkins/GitHub Actions pipelines)

At push time, layers that already exist (same digest) are **skipped**:

```
The push refers to repository [xxx.dkr.ecr.ap-south-1.amazonaws.com/watsonx-app]
a3f5e8d9c2b1: Layer already exists
7b2c4d1e9f8a: Pushed
latest: digest: sha256:... size: 1234
```

Why this matters: if base image layers don't change, push/pull becomes much faster - improving CI/CD pipeline speed.

---
⬅️ [theory.md](./theory.md) | ➡️ [dockerhub.md](./dockerhub.md)
