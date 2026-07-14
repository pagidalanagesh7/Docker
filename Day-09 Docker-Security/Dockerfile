# ---------- Stage 1: Build ----------
FROM node:20-alpine AS builder

WORKDIR /app

# Install deps first (better layer caching)
COPY package*.json ./
RUN npm ci --omit=dev

COPY . .
RUN npm run build

# ---------- Stage 2: Runtime (hardened) ----------
FROM node:20-alpine AS runtime

# Create a dedicated non-root user/group
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

WORKDIR /app

# Copy only what's needed from the build stage — no build tools, no source maps of secrets
COPY --from=builder --chown=appuser:appgroup /app/dist ./dist
COPY --from=builder --chown=appuser:appgroup /app/node_modules ./node_modules
COPY --from=builder --chown=appuser:appgroup /app/package.json ./package.json

# Drop to non-root
USER appuser

# Bind to all interfaces so K8s readiness/liveness probes can reach it
ENV HOST=0.0.0.0
ENV PORT=8080
EXPOSE 8080

# No shell-form CMD (avoids extra shell process, cleaner signal handling)
CMD ["node", "dist/server.js"]

# ---- Recommended accompanying K8s securityContext (put in your Deployment manifest) ----
# securityContext:
#   runAsNonRoot: true
#   runAsUser: 1000
#   readOnlyRootFilesystem: true
#   allowPrivilegeEscalation: false
#   capabilities:
#     drop: ["ALL"]
