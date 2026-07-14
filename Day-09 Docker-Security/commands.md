# Docker Security — Handy Commands

## Image scanning

```bash
# Trivy - scan an image for CVEs
trivy image myapp:latest

# Trivy - fail build on HIGH/CRITICAL only
trivy image --severity HIGH,CRITICAL --exit-code 1 myapp:latest

# Grype alternative
grype myapp:latest
```

## Inspecting what a container can actually do

```bash
# See capabilities a running container has
docker inspect --format='{{.HostConfig.CapAdd}} {{.HostConfig.CapDrop}}' <container>

# Check if a container is running as root
docker exec <container> whoami

# Check running processes' UID mapping
docker exec <container> id
```

## Hardening at runtime

```bash
# Drop all capabilities, add back only what's needed
docker run --cap-drop=ALL --cap-add=NET_BIND_SERVICE myapp

# Read-only root filesystem
docker run --read-only --tmpfs /tmp myapp

# Explicit resource limits
docker run --memory="512m" --cpus="1.0" myapp

# Run as a specific non-root UID
docker run --user 1000:1000 myapp

# Disable privilege escalation
docker run --security-opt=no-new-privileges myapp
```

## Auditing the Docker daemon itself

```bash
# Docker Bench for Security - CIS benchmark audit
docker run --rm --net host --pid host --userns host --cap-add audit_control \
  -v /var/lib:/var/lib -v /var/run/docker.sock:/var/run/docker.sock \
  -v /etc:/etc --label docker_bench_security \
  docker/docker-bench-security
```

## Kubernetes/EKS side

```bash
# Check pod security context
kubectl get pod <pod> -o jsonpath='{.spec.securityContext}'

# Check if any pods in a namespace run privileged
kubectl get pods -n <namespace> -o json | \
  jq '.items[] | select(.spec.containers[].securityContext.privileged==true) | .metadata.name'

# Check IRSA role attached to a service account
kubectl get sa <service-account> -n <namespace> -o yaml | grep eks.amazonaws.com/role-arn

# List NetworkPolicies in a namespace
kubectl get networkpolicy -n <namespace>

# ECR - scan an image on push (one-off manual trigger)
aws ecr start-image-scan --repository-name <repo> --image-id imageTag=<tag>

# ECR - get scan findings
aws ecr describe-image-scan-findings --repository-name <repo> --image-id imageTag=<tag>
```

## Quick "is this container dangerous" checklist

```bash
docker inspect <container> --format '
Privileged: {{.HostConfig.Privileged}}
CapAdd: {{.HostConfig.CapAdd}}
NetworkMode: {{.HostConfig.NetworkMode}}
ReadonlyRootfs: {{.HostConfig.ReadonlyRootfs}}
'
```
