# Docker Registry - Best Practices ✅

## 1. Tagging Strategy

- ❌ Avoid the `latest` tag in production
- ✅ Use semantic versioning: `v1.2.3`
- ✅ Use git commit SHA for traceability: `watsonx-app:a3f5e8d`
- ✅ Use environment-specific tags: `v1.2.3-staging`, `v1.2.3-prod`

## 2. Security

- Enable **image scanning** (ECR: `scanOnPush=true`) - catch vulnerabilities right at push time
- Use **immutable tags** - prevent accidental/malicious overwrites
- **Least privilege IAM** - only give push permission to CI/CD service accounts, developers get read-only
- Keep private repos private by default, avoid public exposure
- Use only trusted base images (official images, verified publishers)

## 3. Cost Optimization

- Set up **lifecycle policies** - auto-expire untagged/old images
- Periodically audit and delete unused repositories
- Use multi-stage builds to reduce image size (storage cost scales directly with image size)

## 4. CI/CD Integration

- Handle registry authentication via pipeline secrets/IAM roles, never hardcoded credentials
- Split the pipeline into Build → Tag → Scan → Push → Deploy stages
- Only allow deployment after every pushed image passes its scan (gate check)

## 5. High Availability & DR

- Enable ECR **cross-region replication** for critical images
- For multi-region deployments, maintain a local ECR repo replica in each region (to reduce latency)

## 6. Rate Limit Avoidance

- Don't pull public Docker Hub images directly in production - mirror them into an internal registry (ECR)
- Use ECR's **Pull Through Cache** feature for automatic mirroring

## 7. Kubernetes-Specific

- Use `imagePullPolicy: IfNotPresent` in production (unless using `latest`, in which case `Always` is needed - but as mentioned, avoid `latest`)
- Node-level image caching avoids repeated pulls, speeding up deployments
- Manage `imagePullSecrets` securely as Kubernetes Secrets, and rotate them periodically

## 8. Monitoring & Auditing

- Audit ECR API calls via CloudTrail - track who pushed/pulled and when
- Set up CloudWatch metrics/alarms for unusual push/pull activity
- Periodically review repository access logs

## Quick Checklist Before Production Push

- [ ] Image scanned, no critical vulnerabilities
- [ ] Tag follows semantic versioning / commit SHA convention
- [ ] Immutable tag policy enabled
- [ ] Multi-stage build used (minimal final image size)
- [ ] IAM permissions least-privilege
- [ ] Lifecycle policy configured

---
⬅️ [interview-questions.md](./interview-questions.md) | ⬆️ [Back to README](./README.md)
