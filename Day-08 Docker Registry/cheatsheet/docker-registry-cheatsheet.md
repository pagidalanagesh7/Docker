# 🐳 Docker Registry Cheatsheet

## Docker Hub

| Action | Command |
|---|---|
| Login | `docker login` |
| Tag | `docker tag <image>:<tag> <user>/<repo>:<tag>` |
| Push | `docker push <user>/<repo>:<tag>` |
| Pull | `docker pull <user>/<repo>:<tag>` |
| Logout | `docker logout` |

## AWS ECR

| Action | Command |
|---|---|
| Authenticate | `aws ecr get-login-password --region <region> \| docker login --username AWS --password-stdin <account>.dkr.ecr.<region>.amazonaws.com` |
| Create repo | `aws ecr create-repository --repository-name <repo> --region <region>` |
| Tag | `docker tag <image>:<tag> <account>.dkr.ecr.<region>.amazonaws.com/<repo>:<tag>` |
| Push | `docker push <account>.dkr.ecr.<region>.amazonaws.com/<repo>:<tag>` |
| Pull | `docker pull <account>.dkr.ecr.<region>.amazonaws.com/<repo>:<tag>` |
| List images | `aws ecr describe-images --repository-name <repo>` |
| Delete tag | `aws ecr batch-delete-image --repository-name <repo> --image-ids imageTag=<tag>` |
| Set immutable tags | `aws ecr put-image-tag-mutability --repository-name <repo> --image-tag-mutability IMMUTABLE` |

## Inspection & Debug

| Action | Command |
|---|---|
| Manifest inspect | `docker manifest inspect <image>` |
| Show digests | `docker images --digests` |
| Pod pull error debug | `kubectl describe pod <pod> -n <ns>` |
| Check events | `kubectl get events -n <ns> --sort-by='.lastTimestamp'` |

## Kubernetes Pull Secret

```bash
kubectl create secret docker-registry regcred \
  --docker-server=<registry-url> \
  --docker-username=<user> \
  --docker-password=<pass> \
  -n <namespace>
```

## Common Errors → Fixes

| Error | Fix |
|---|---|
| `toomanyrequests` | Docker Hub rate limit → mirror to ECR / authenticate |
| `manifest not found` | Wrong/non-existent tag → verify tag exists |
| `no basic auth credentials` | Re-authenticate (ECR token expires in 12h) |
| `ImagePullBackOff` | Check tag, IAM perms, imagePullSecrets |

## Golden Rules

- ❌ Never use `latest` in production
- ✅ Use semantic versioning or git SHA tags
- ✅ Enable image scanning on push
- ✅ Enable immutable tags
- ✅ Set lifecycle policies for cost control

---
[⬆️ Back to README](../README.md)
