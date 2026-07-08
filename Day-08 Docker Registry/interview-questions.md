# Docker Registry - Interview Questions (Scenario-Based) 🎯

## Q1. In production, `docker pull` fails with a "toomanyrequests" error. What's the root cause and how do you fix it?

**Answer**: This indicates Docker Hub's anonymous/free-tier pull rate limit (100-200 pulls/6hrs per IP) has been hit. This happens quickly when multiple EKS nodes share the same IP via a NAT Gateway.

**Fix**:
1. Immediate: Log in with an authenticated Docker Hub account to raise the limit
2. Long-term: Mirror public images (nginx, python, etc.) into AWS ECR and pull from there - ECR has no rate limits
3. Use ECR's **Pull Through Cache** feature (available since 2023) for automatic mirroring of Docker Hub images

## Q2. After a deployment update, a pod is stuck in `ImagePullBackOff`. What are the debug steps?

**Answer**:
```bash
kubectl describe pod <pod-name> -n <namespace>
# Check the Events section for the exact error message

kubectl get events -n <namespace> --sort-by='.lastTimestamp'
```

Common causes:
- Wrong image tag (typo, non-existent version) → verify with `aws ecr describe-images`
- Auth issue - the IAM role lacks ECR pull permissions (`ecr:GetDownloadUrlForLayer`, `ecr:BatchGetImage`)
- Missing `imagePullSecrets` for a private registry
- Network issue - VPC endpoint/NAT gateway reachability

## Q3. You get a "no basic auth credentials" error when pushing to ECR. What's happening?

**Answer**: The ECR authentication token has expired (valid for 12 hours) or you never logged in. Fix:

```bash
aws ecr get-login-password --region ap-south-1 | \
docker login --username AWS --password-stdin <account-id>.dkr.ecr.ap-south-1.amazonaws.com
```

This should be automated in CI/CD pipelines - a fresh token should be generated before every build stage, since tokens become invalid after 12 hours.

## Q4. What's the risk of using the `latest` tag in production?

**Answer**: `latest` is a floating tag - there's no guarantee it points to any specific version, and it can be overwritten at any time.

**Risks**:
- Rollback becomes impossible - you don't know "which version was `latest` yesterday"
- Different environments (dev/staging/prod) pulling at different times may end up running different actual versions
- Without `imagePullPolicy: Always` in Kubernetes, a node might use an old cached `latest` (inconsistent state)

**Best practice**: Use semantic versioning (`v1.2.3`) or git commit SHA (`a3f5e8d`), and avoid `latest` in production.

## Q5. Two teams push to the same ECR repository, and occasionally the wrong image gets deployed. How do you solve this?

**Answer**: 
- Enforce a repository naming convention: `team-name/service-name`
- Auto-generate image tags in the CI pipeline from the git commit SHA or pipeline build number (avoid manual tagging)
- Enable ECR's **immutable tags** feature - once a tag is pushed, it can't be overwritten:
```bash
aws ecr put-image-tag-mutability \
  --repository-name watsonx-app \
  --image-tag-mutability IMMUTABLE
```
- Restrict push permissions to be team-specific via IAM policies

## Q6. ECR storage costs keep growing. How do you optimize them?

**Answer**:
1. Set up **lifecycle policies** - auto-expire untagged images after 7-30 days
2. Identify and manually clean up old/unused tagged versions (`aws ecr batch-delete-image`)
3. Use multi-stage Dockerfile builds to reduce image sizes (linking back to the Day 7 concept)
4. Keep base image layers common across images to encourage layer reuse

## Q7. Docker Registry (self-hosted, e.g., Harbor) vs managed (ECR) - when do you use which?

**Answer**:
- **Managed (ECR)**: Ideal for AWS-native workloads - IAM integration, no infra maintenance, automatic scaling. This is what we use for our IBM Watsonx EKS workloads.
- **Self-hosted (Harbor)**: Better for multi-cloud/hybrid environments, strict compliance requirements (data residency), or when you need advanced RBAC + vulnerability scanning policies.

Trade-off: Self-hosted means you maintain it yourself (HA, backups, scaling) - more operational overhead.

---
⬅️ [examples.md](./examples.md) | ➡️ [best-practices.md](./best-practices.md)
