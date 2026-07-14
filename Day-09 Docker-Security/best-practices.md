# Docker Security — Best Practices Checklist (AWS/EKS context)

## ✅ Image build time

- [ ] Use minimal base images (`distroless`, `alpine`, or slim variants)
- [ ] Pin base images by **digest**, not just tag (`image@sha256:...`)
- [ ] Multi-stage builds — never ship build tools/secrets in final image
- [ ] Add a dedicated non-root `USER` in the Dockerfile
- [ ] `.dockerignore` your `.git`, `.env`, and any local secrets
- [ ] Scan images in CI (Trivy/Grype) — fail the Jenkins/GitHub Actions
      pipeline on HIGH/CRITICAL CVEs before push to **ECR**
- [ ] Sign images (Cosign) if pipeline maturity allows it

## ✅ Runtime

- [ ] Run containers as **non-root** (`runAsNonRoot: true` in K8s)
- [ ] `readOnlyRootFilesystem: true` unless the app genuinely needs write
- [ ] `--cap-drop=ALL`, add back only what's required
- [ ] Never mount `/var/run/docker.sock` into app containers
- [ ] Never use `--privileged` for application workloads
- [ ] Set explicit CPU/memory `requests` and `limits`
- [ ] Use `securityContext.allowPrivilegeEscalation: false`

## ✅ Kubernetes / EKS layer

- [ ] Enforce **Pod Security Admission** `restricted` profile per namespace
- [ ] Scope **IRSA** roles tightly — one service account, one narrow policy
- [ ] Default-deny **NetworkPolicies**, allow only required pod-to-pod paths
- [ ] Store secrets in **AWS Secrets Manager / Parameter Store**, not
      plain K8s Secrets (or at least enable envelope encryption via KMS)
- [ ] Enable **EKS control plane logging** (audit, authenticator logs) to
      CloudWatch
- [ ] Use **ECR image scanning on push** (basic or enhanced/Inspector)
- [ ] Rotate node AMIs regularly — patch the underlying kernel

## ✅ CI/CD pipeline

- [ ] Vulnerability scan gate before merge/deploy
- [ ] No hardcoded credentials in Jenkinsfile / GitHub Actions YAML —
      use OIDC federation to assume an AWS role, not long-lived keys
- [ ] Immutable image tags (no `latest` in production manifests)
- [ ] ArgoCD syncs only from a protected branch with required reviews

## ✅ Monitoring & incident response

- [ ] Runtime threat detection — **Falco** or **GuardDuty for EKS**
- [ ] Alert on anomalous syscalls, unexpected outbound connections
- [ ] Centralize logs (Prometheus/Grafana + CloudWatch) so a compromised
      pod's activity is visible, not just its "up/down" status
- [ ] Have a documented "kill switch" — cordon + drain a compromised node
      fast, rotate any IAM credentials that pod could have touched
