# Docker Security — Theory

## 1. Why containers aren't VMs (security-wise)

Containers share the **host kernel**. A VM has its own kernel, so a kernel
exploit inside a VM is contained to that VM. A kernel exploit inside a
container can potentially reach the **host** and every other container on
it. That's the #1 mental model shift: containers are process isolation,
not full isolation.

## 2. The 4 pillars of container isolation

| Pillar | What it does |
|---|---|
| **Namespaces** | Isolate what a process can *see* (PID, NET, MNT, UTS, IPC, USER) |
| **Cgroups** | Limit what a process can *use* (CPU, memory, I/O) |
| **Capabilities** | Limit what a process can *do* (fine-grained root privileges) |
| **Seccomp/AppArmor/SELinux** | Restrict which *syscalls* a process can make |

If any one of these is misconfigured, you weaken the whole model —
e.g. running `--privileged` disables almost all of the above at once.

## 3. The core threat model

- **Image-level risk**: vulnerable base images, embedded secrets, malicious
  packages pulled from public registries.
- **Runtime risk**: containers running as root, mounting the Docker socket,
  excessive Linux capabilities, no resource limits.
- **Orchestration risk** (Kubernetes/EKS): overly permissive RBAC,
  IAM roles attached to service accounts (IRSA) with broad permissions,
  missing network policies between pods.
- **Supply chain risk**: unsigned images, no SBOM, no vulnerability scanning
  in the CI/CD pipeline before push to ECR.

## 4. Defense in depth for containers

Security isn't one control — it's layers:

1. Secure the **image** (minimal base, no secrets, scanned).
2. Secure the **container runtime** (non-root, read-only FS, dropped caps).
3. Secure the **orchestrator** (K8s RBAC, PodSecurity admission, network
   policies, IRSA scoped tightly).
4. Secure the **host** (patched kernel, CIS-benchmarked Docker daemon).
5. Secure the **pipeline** (image scanning gates in Jenkins/GitHub Actions
   before anything reaches EKS).

Every one of these maps to something you can actually configure —
covered next in `docker-security.md` and `best-practices.md`.
