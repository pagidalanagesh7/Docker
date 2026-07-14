# Docker Security — Deep Dive

## Namespaces (Isolation of View)

| Namespace | Isolates |
|---|---|
| PID | Process IDs — container can't see host processes |
| NET | Network stack — own IP, ports, routing table |
| MNT | Filesystem mount points |
| UTS | Hostname |
| IPC | Inter-process communication |
| USER | UID/GID mapping (container root ≠ host root, if configured) |

⚠️ **Gotcha**: By default, USER namespace remapping is *not* enabled in
Docker. That means "root" inside your container is literally UID 0 on the
host unless you explicitly enable `userns-remap` or run as a non-root user.

## Cgroups (Control of Resources)

Cgroups stop one noisy/compromised container from starving the whole
EC2 node. Without limits, a crypto-mining payload inside a compromised
container can eat 100% CPU across the node — including other workloads'
pods in the same EKS node group.

```bash
docker run -d --memory="512m" --cpus="1.0" myapp
```

## Linux Capabilities

Root inside a container has ~40 capabilities by default (`CAP_NET_RAW`,
`CAP_SYS_ADMIN`, etc.) — most apps need **zero** of them.

```bash
docker run --cap-drop=ALL --cap-add=NET_BIND_SERVICE myapp
```

Only add back exactly what's required (e.g. `NET_BIND_SERVICE` if binding
to port < 1024).

## Seccomp / AppArmor

Docker ships a **default seccomp profile** that blocks ~44 dangerous
syscalls (like `reboot`, `mount`, `kexec_load`) out of the box. Don't
disable it with `--security-opt seccomp=unconfined` unless you have a very
specific reason — this is a common finding in security audits.

## The Docker Socket — the #1 privilege escalation path

```bash
# NEVER do this in production
docker run -v /var/run/docker.sock:/var/run/docker.sock myapp
```

Mounting the Docker socket into a container = giving that container full
root control of the **host**, because it can now talk to the daemon and
spin up new privileged containers itself. This is one of the most common
real-world container breakout techniques.

## `--privileged` mode

Disables namespaces, cgroup limits, capability drops, and seccomp
essentially all at once. Effectively the container *is* the host. Only
ever used for things like Docker-in-Docker CI runners, and even then,
prefer rootless alternatives (e.g. `sysbox`, `kaniko` for image builds
instead of DinD).

## Image-layer risks

- Base images from unverified sources (always pin a digest, not just a tag).
- Secrets baked into layers (even if deleted in a later layer, they persist
  in image history — use multi-stage builds or BuildKit secrets).
- Unscanned images pushed straight to ECR without a Trivy/Grype/ECR-native
  scan gate in the pipeline.

## Kubernetes/EKS-specific extensions

- **Pod Security Admission** (replaces PodSecurityPolicy) — enforce
  `restricted` profile: no privileged pods, no host namespaces, must run
  as non-root.
- **IRSA (IAM Roles for Service Accounts)** — scope IAM policies to the
  *narrowest* permission set per service account, never attach broad
  admin-like roles to a pod's service account.
- **NetworkPolicies** — default-deny between namespaces; only allow explicit
  traffic (e.g. `ica-scribeflow` should not freely talk to unrelated
  namespaces).
- **Read-only root filesystem** (`readOnlyRootFilesystem: true`) — stops
  a compromised process from writing a backdoor/binary to disk.
