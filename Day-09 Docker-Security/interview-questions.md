# Docker Security — Scenario-Based Interview Questions

### Q1. A container in your EKS cluster was found running as root with no
resource limits. Walk me through how you'd remediate it, and how you'd
prevent it from happening again.

**What they're testing**: Do you jump straight to a one-off fix, or think
in terms of prevention (admission control, CI gates)?

**Good answer shape**: Immediate fix — patch the Dockerfile with a `USER`
directive, add `resources.requests/limits` in the manifest, redeploy.
Prevention — enforce Pod Security Admission `restricted` profile on the
namespace so this class of misconfiguration can't be scheduled again, and
add an OPA/Kyverno policy check in the CI pipeline before merge.

---

### Q2. You find `/var/run/docker.sock` mounted into a running pod. Why is
this dangerous, and what would you use instead for the use case (e.g.
building images in CI)?

**Good answer shape**: Explain socket access ≈ root on host. Replace with
Kaniko or Buildah for daemonless image builds inside CI runners.

---

### Q3. Your team wants to migrate from PodSecurityPolicy to Pod Security
Admission. What's the practical migration path for a live EKS cluster with
many namespaces?

**Good answer shape**: Start with `warn`/`audit` mode on `restricted` per
namespace to surface violations without breaking anything, fix flagged
workloads incrementally, then flip to `enforce` namespace by namespace,
starting with lowest-risk namespaces first.

---

### Q4. A pod's service account has an IRSA role with far more permissions
than it needs. How do you identify this, and how do you fix it without
breaking the app?

**Good answer shape**: Use AWS IAM Access Analyzer / CloudTrail to see
which actions the role *actually* used over time, then rewrite the policy
to that minimal set, test in staging, roll out via the IaC (Terraform)
pipeline rather than hand-editing in the console.

---

### Q5. How would you detect that a running container has been compromised
and is trying to do something it shouldn't (e.g. crypto-mining, reverse
shell)?

**Good answer shape**: Runtime security tooling like **Falco** or
**GuardDuty for EKS** watching for anomalous syscalls/outbound connections;
CloudWatch alarms on unusual CPU spikes; centralized logging so you can
correlate a spike with a specific pod/namespace quickly.

---

### Q6. Explain the difference between a namespace, a cgroup, and a
capability in Docker — and give an attack scenario each one specifically
defends against.

**Good answer shape**:
- Namespace → PID namespace stops a container from seeing/killing host
  processes.
- Cgroup → memory limit stops a container from OOM-killing the whole node.
- Capability → dropping `CAP_SYS_ADMIN` stops a container from mounting
  arbitrary filesystems or doing kernel-level operations even as "root"
  inside the container.

---

### Q7. Your CI pipeline pushes an image straight to ECR with no scanning
step. What's the risk, and how do you fix it with minimal pipeline
disruption?

**Good answer shape**: Risk = shipping known CVEs straight to prod.
Fix = add a Trivy/Grype scan stage (or enable ECR enhanced scanning) that
fails the build on HIGH/CRITICAL findings, ideally before the image is
even pushed, not after.

---

### Q8. What's the actual difference between `--privileged` and giving a
container `--cap-add=SYS_ADMIN`? When (if ever) would you use
`--privileged` in production?

**Good answer shape**: `--privileged` disables nearly all isolation
(namespaces, cgroup limits, seccomp, all capabilities) — the container is
effectively the host. `--cap-add=SYS_ADMIN` grants just one specific
capability while keeping everything else restricted. `--privileged` should
essentially never be used for application workloads in production; the
few legitimate cases (certain DinD/CI runners) should be isolated on
dedicated, tightly controlled nodes.

---

### Q9. How do secrets end up leaking through Docker images even when
"deleted" in a later layer, and how do you prevent it?

**Good answer shape**: Layers are immutable and additive — deleting a file
in a later `RUN` doesn't remove it from the earlier layer's filesystem
diff; it's still recoverable from the image history. Prevention: use
BuildKit's `--secret` mount (never `COPY`/`ARG` for secrets), multi-stage
builds where the secret only ever touches an intermediate stage that isn't
in the final image.

---

### Q10. How would you design NetworkPolicies for a set of namespaces like
`ica-scribeflow` and `ica-integrations` so a compromise in one can't move
laterally into the other?

**Good answer shape**: Default-deny ingress/egress per namespace, then
explicit allow rules only for the specific pod-to-pod/service
communication paths that are actually required, verified against real
traffic (e.g. via Cilium Hubble or VPC flow logs) rather than guessed.
