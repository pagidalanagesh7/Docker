# Dockerfile & Image Optimization - Interview Questions

## Conceptual Questions

**Q1. What is a Dockerfile and how does it differ from a docker-compose.yml file?**
A Dockerfile defines how to build a single image (instructions like FROM, RUN, COPY). A docker-compose.yml defines how to run and orchestrate multiple containers/services together, including networking and volumes, typically referencing one or more Dockerfiles or pre-built images.

**Q2. What are Docker image layers and why do they matter?**
Each instruction in a Dockerfile (except a few like `CMD`/`ENTRYPOINT` in some cases) creates a new layer. Layers are cached, so unchanged layers are reused across builds, speeding up rebuilds. Layer count and size directly affect final image size and build performance.

**Q3. What is a multi-stage build and why use it?**
A multi-stage build uses multiple `FROM` statements in a single Dockerfile, where each stage can use a different base image. Only the final stage's output goes into the final image, allowing you to discard build tools, source code, and intermediate artifacts — drastically reducing final image size.

**Q4. Difference between COPY and ADD?**
`COPY` simply copies files/directories from host to image. `ADD` does everything COPY does, plus it can extract local tar archives automatically and fetch remote URLs. Best practice: prefer `COPY` unless you specifically need ADD's extra behavior.

**Q5. Difference between CMD and ENTRYPOINT?**
`CMD` provides default arguments that can be easily overridden at `docker run`. `ENTRYPOINT` defines a fixed executable that always runs, with `CMD` values passed as default arguments to it. Often used together: `ENTRYPOINT ["java","-jar"]` + `CMD ["app.jar"]`.

**Q6. Why should you avoid running containers as root?**
Running as root inside a container increases the security risk if the container is compromised, since a container escape could grant root-level access on the host. Best practice is to create/use a non-root `USER` in the Dockerfile.

**Q7. What is the purpose of .dockerignore?**
It excludes unnecessary files (e.g., `.git`, `node_modules`, logs, secrets) from being sent to the Docker daemon as part of the build context, which speeds up builds and prevents accidental leakage of sensitive files into the image.

**Q8. How does instruction ordering affect build caching?**
Docker caches each layer and only rebuilds from the first changed instruction onward. Placing rarely-changing instructions (like dependency installation) before frequently-changing ones (like source code copy) maximizes cache reuse and speeds up rebuilds.

**Q9. What's the difference between `alpine`, `slim`, and `distroless` base images?**
`alpine` is a minimal Linux distro (~5MB) using musl libc, which can cause compatibility issues with some binaries. `slim` variants are Debian-based with fewer preinstalled packages than the full image. `distroless` images contain only the application and its runtime dependencies — no shell, no package manager — offering the smallest attack surface but harder to debug.

**Q10. How would you reduce the number of layers in a Dockerfile?**
Combine related commands using `&&` in a single `RUN` instruction, and clean up temporary files (like apt cache) within the same `RUN` layer so they don't persist in an earlier layer.

## Scenario-Based Questions

**Q11. Your Node.js image is 1.2GB and deployments to EKS are slow. How do you troubleshoot and fix this?**
- Run `docker history` to identify large layers
- Check if `node_modules` is being copied unnecessarily or if dev dependencies are included
- Switch to a multi-stage build separating build and runtime
- Switch base image to `node:alpine`
- Add a `.dockerignore` to exclude `node_modules`, `.git`, logs
- Rebuild and compare sizes before pushing to ECR

**Q12. A teammate keeps getting cache invalidation on every build even for small code changes, causing full `npm install` every time. What's wrong?**
Likely the Dockerfile copies all source code (`COPY . .`) before running `npm install`, so any file change invalidates the cache for the install layer too. Fix: copy `package*.json` first, run `npm install`, then copy the rest of the source code afterward.

**Q13. How would you securely handle secrets (like DB passwords) needed during a Docker build without baking them into image layers?**
Avoid `ARG`/`ENV` for secrets since they persist in image history/layers. Use Docker BuildKit's `--secret` flag to mount secrets only during the build without persisting them in the final image, or fetch secrets at runtime via AWS Secrets Manager/Parameter Store rather than at build time.

**Q14. Your CI/CD pipeline pushes a new image on every commit to ECR, and storage costs are growing quickly. What optimizations would you apply?**
- Enable ECR lifecycle policies to expire old/untagged images
- Optimize Dockerfile size (multi-stage, alpine/distroless)
- Reuse cached layers across builds (consistent tagging strategy, layer caching in CI)
- Consider immutable tags with a reasonable retention policy

**Q15. How do you debug a `distroless` container that has no shell, when something goes wrong at runtime?**
Since there's no shell for `docker exec`, options include: checking `docker logs`, adding a temporary debug variant of the image with a shell for troubleshooting, using ephemeral debug containers (`kubectl debug` in Kubernetes/EKS with a debug image attached to the pod), or relying on structured application logging and health checks.

**Q16. How would you optimize a Java Spring Boot app's Docker image that currently ships the full JDK and Maven toolchain (900MB) into production?**
Use a multi-stage build: build the JAR in a `maven` stage, then copy only the built JAR into a minimal `eclipse-temurin:jre-alpine` (or similar JRE-only) runtime image, eliminating Maven, source code, and JDK compiler tools from the final image.

**Q17. Explain how you'd design a Dockerfile for a Python app to support both fast local development iteration and a small production image.**
Use multi-stage builds with build-time `ARG` (e.g., `ARG ENV=production`) to conditionally include dev tools, or maintain a `Dockerfile.dev` with hot-reload/debug tools and a separate optimized `Dockerfile` for production with `--no-cache-dir` pip installs and a slim/distroless final stage.
