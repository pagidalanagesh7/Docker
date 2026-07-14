# Docker Security — Real-World Style Scenarios (Watsonx/EKS-flavored)

## Scenario 1: The socket mount that leaked cluster-admin

**Setup**: A CI helper container running inside an EKS pod had
`/var/run/docker.sock` mounted so it could "build images inside the
pipeline step."

**Problem**: Any process that could exec into that pod could now talk to
the Docker daemon directly — spin up a new privileged container, mount the
host filesystem, and read kubelet credentials or node IAM role tokens from
the EC2 instance metadata service.

**Fix**: Replaced Docker-in-Docker with **Kaniko** (builds images without a
daemon, no socket needed) inside the Jenkins/GitHub Actions pipeline.

---

## Scenario 2: A `CrashLoopBackOff` that was actually a security control working

**Setup**: A namespace similar to `ica-scribeflow` had a pod stuck in
`CrashLoopBackOff` after a Pod Security Admission policy was tightened to
`restricted`.

**Root cause**: The container's Dockerfile didn't define a non-root `USER`,
so it defaulted to UID 0. Under `restricted` PSA, `runAsNonRoot: true` is
enforced — the pod was correctly being blocked from starting as root.

**Fix**: Added `USER 1000` in the Dockerfile, rebuilt, pushed a new tag to
ECR, updated the Helm values, and let ArgoCD sync. Pod started clean.

---

## Scenario 3: Over-permissioned IRSA role

**Setup**: A service account in an `ica-integrations`-style namespace had
an IRSA role attached with `AmazonS3FullAccess` and
`AmazonDynamoDBFullAccess`, when the pod only needed read access to one
specific S3 bucket.

**Risk**: If that pod were ever compromised (e.g. via a vulnerable
dependency), the attacker would inherit full S3 and DynamoDB access across
the **entire account**, not just the one bucket the app actually used.

**Fix**: Rewrote the IAM policy to scope down to
`s3:GetObject`/`s3:ListBucket` on the exact bucket ARN only, removed
DynamoDB permissions entirely, and re-attached via the service account
annotation.

---

## Scenario 4: Readiness probe failure that was really a `0.0.0.0` vs `127.0.0.1` bug — but flagged by the security review anyway

**Setup**: A FastAPI/uvicorn app bound to `127.0.0.1` only, so the K8s
readiness probe (hitting the pod IP) failed and the pod never became
Ready.

**Extra security angle surfaced during the fix**: while patching the bind
address to `0.0.0.0`, the review also caught that the container was
running the app as root with no `readOnlyRootFilesystem`, and NetworkPolicy
for the namespace was missing entirely — meaning once traffic could reach
the pod, there was no restriction on what else that pod could talk to
laterally.

**Fix**: Bound to `0.0.0.0:8000`, added `runAsNonRoot`,
`readOnlyRootFilesystem: true`, and a default-deny NetworkPolicy scoped to
allow only the required upstream/downstream services.

---

## Scenario 5: A "quick" `--privileged` container in a Free Fire-style side project 🎮

Even outside prod — in a home-lab (Rancher Desktop/k3s) setup — running a
monitoring agent with `--privileged` "just to get it working faster" is a
common shortcut. It works, but it's exactly the kind of habit that later
shows up as a critical finding in a real cluster's security audit. Worth
practicing the *correct* flags (`--cap-add` for just what's needed) even
in throwaway home-lab environments, so it becomes muscle memory for
production EKS work.
