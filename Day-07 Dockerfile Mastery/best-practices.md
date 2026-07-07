# Dockerfile & Image Optimization - Best Practices Checklist

## ✅ Base Image
- [ ] Use minimal base images (`alpine`, `slim`, or `distroless`) wherever compatible
- [ ] Pin specific image versions/tags (avoid `latest`) for reproducible builds
- [ ] Regularly update base images to pick up security patches

## ✅ Build Structure
- [ ] Use multi-stage builds to separate build-time and run-time dependencies
- [ ] Only copy final build artifacts into the last stage
- [ ] Name stages clearly (`AS builder`, `AS runtime`) for readability

## ✅ Layer & Cache Optimization
- [ ] Order instructions from least-frequently-changed to most-frequently-changed
- [ ] Copy dependency manifests (`package.json`, `requirements.txt`, `pom.xml`) before copying full source code
- [ ] Combine related `RUN` commands with `&&` to minimize layer count
- [ ] Clean up package manager caches within the same `RUN` layer (e.g., `rm -rf /var/lib/apt/lists/*`)

## ✅ Build Context
- [ ] Always include a `.dockerignore` file
- [ ] Exclude `.git`, `node_modules`, build artifacts, logs, and secrets from build context

## ✅ Security
- [ ] Run containers as a non-root `USER`
- [ ] Never hardcode secrets/credentials in Dockerfile or `ENV`
- [ ] Use BuildKit `--secret` for build-time secrets
- [ ] Scan images regularly (Trivy, Docker Scout, AWS ECR scanning)
- [ ] Avoid installing unnecessary packages/tools in the final image

## ✅ Image Size
- [ ] Compare before/after sizes using `docker images` and `docker history`
- [ ] Use `dive` to analyze layer contents
- [ ] Remove build tools, compilers, and dev dependencies from final stage
- [ ] Avoid copying entire directories when only specific files are needed

## ✅ Runtime Configuration
- [ ] Use `EXPOSE` to document ports (doesn't publish them, but improves clarity)
- [ ] Set sensible `WORKDIR` instead of relying on default paths
- [ ] Add a `HEALTHCHECK` instruction for better orchestration visibility (ECS/EKS)
- [ ] Use `ENTRYPOINT` + `CMD` combo for flexible, predictable startup behavior

## ✅ CI/CD & AWS-Specific
- [ ] Tag images with commit SHA or semantic version, not just `latest`, for traceability
- [ ] Push optimized images to Amazon ECR to reduce storage/transfer costs
- [ ] Enable ECR lifecycle policies to clean up old/untagged images
- [ ] Enable ECR image scanning on push
- [ ] Cache Docker layers in CI/CD pipelines (Jenkins/GitHub Actions) to speed up builds
- [ ] Validate final image size as a pipeline gate (fail build if image exceeds threshold)

## ✅ Documentation & Maintainability
- [ ] Add comments in Dockerfile explaining non-obvious steps
- [ ] Keep a consistent Dockerfile structure across services/repos
- [ ] Document base image choice and rationale in README
