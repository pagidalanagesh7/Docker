# Docker Hub - Deep Dive 🐋

## What is Docker Hub?

**Docker Hub** is Docker Inc's official, default public registry. When you run `docker pull nginx`, by default the image comes from Docker Hub (`docker.io/library/nginx`).

## Public vs Private Repositories

| Feature | Public Repo | Private Repo |
|---|---|---|
| Visibility | Everyone can pull | Only authenticated users/teams |
| Free tier | Unlimited | 1 free private repo (personal plan) |
| Use case | Open source images | Company/internal apps |

## Official Images vs Community Images

- **Official Images** (e.g., `nginx`, `postgres`, `python`) - maintained by Docker Inc + vendors, security-vetted, under the `library/` namespace
- **Verified Publisher** - companies like Bitnami, with a verified badge
- **Community/User Images** - `username/imagename` format, anyone can push

```bash
docker pull nginx              # official image
docker pull bitnami/nginx      # verified publisher
docker pull nagesh/myapp       # community/personal image
```

## Docker Hub Rate Limits (IMPORTANT - production impact!)

Since 2020, Docker Hub has enforced **pull rate limits**:

| Account Type | Pull Limit |
|---|---|
| Anonymous (no login) | 100 pulls / 6 hours per IP |
| Free authenticated | 200 pulls / 6 hours |
| Pro/Team | Higher/unlimited limits |

**Real problem**: If multiple EKS nodes share the same IP (via NAT Gateway), the rate limit gets hit quickly → `ImagePullBackOff` errors!

**Solution in our context**: Mirror public images into ECR as well (via ECR Pull Through Cache or manual mirroring), so Docker Hub's rate limit doesn't cause issues.

## Namespaces & Organizations

```
docker.io/<namespace>/<repo>:<tag>

library/nginx          → official image (namespace not needed in practice)
nagesh/watsonx-demo     → personal namespace
myorg/backend-service   → organization namespace (team access control)
```

## Automated Builds (Legacy Feature)

Docker Hub can link to a GitHub/Bitbucket repo and automatically build+push an image whenever code is pushed (a lightweight CI feature) - most people now use GitHub Actions/Jenkins instead, since they're more flexible.

## Docker Hub vs AWS ECR - Quick Comparison

| Aspect | Docker Hub | AWS ECR |
|---|---|---|
| Auth | Username/password or token | IAM roles/policies |
| Cost | Free tier + paid plans | Pay per storage + data transfer |
| Integration | Generic, cloud-agnostic | Native AWS (EKS, ECS, CodeBuild) |
| Scanning | Pro feature | Built-in (basic + enhanced via Inspector) |
| Rate limits | Yes (strict on free tier) | No pull rate limits within AWS |
| Private repos | Limited on free tier | Private by default |

## Practical Tip (IBM Watsonx Context)

Instead of pulling base images (python, node, nginx) directly from Docker Hub in our EKS clusters, it's best practice to create an internal mirror repo in ECR - this helps with both rate limiting and security scanning.

---
⬅️ [registry-architecture.md](./registry-architecture.md) | ➡️ [commands.md](./commands.md)
