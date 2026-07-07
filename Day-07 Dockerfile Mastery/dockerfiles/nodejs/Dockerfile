# ---- Stage 1: Build/Install Dependencies ----
FROM node:20-alpine AS builder

WORKDIR /app

# Copy only dependency manifests first for better layer caching
COPY package*.json ./

RUN npm ci --only=production

# ---- Stage 2: Final Runtime Image ----
FROM node:20-alpine

WORKDIR /app

# Copy installed node_modules from builder stage
COPY --from=builder /app/node_modules ./node_modules

# Copy application source code
COPY . .

# Run as non-root user (built into official node image)
USER node

EXPOSE 3000

CMD ["node", "app.js"]
