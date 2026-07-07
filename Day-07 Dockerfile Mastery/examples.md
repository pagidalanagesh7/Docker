# Dockerfile & Image Optimization - Examples

## Example 1: Node.js — Unoptimized vs Optimized

### ❌ Unoptimized
```dockerfile
FROM node:20
WORKDIR /app
COPY . .
RUN npm install
CMD ["node", "app.js"]
```
**Problems:**
- Uses full `node` image (~1GB)
- Copies everything (including `node_modules`, `.git`) before install → poor caching
- No multi-stage build, no non-root user
- Runs as root

**Approx size:** ~950MB - 1.1GB

### ✅ Optimized
```dockerfile
FROM node:20-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production

FROM node:20-alpine
WORKDIR /app
COPY --from=builder /app/node_modules ./node_modules
COPY . .
USER node
EXPOSE 3000
CMD ["node", "app.js"]
```
**Improvements:**
- `alpine` base drastically reduces size
- Dependency layer cached separately from source code
- Multi-stage build discards build artifacts
- Runs as non-root `node` user

**Approx size:** ~120-180MB (up to 85% reduction)

---

## Example 2: Python — Unoptimized vs Optimized

### ❌ Unoptimized
```dockerfile
FROM python:3.12
WORKDIR /app
COPY . .
RUN pip install -r requirements.txt
CMD ["python", "app.py"]
```
**Approx size:** ~900MB-1GB

### ✅ Optimized
```dockerfile
FROM python:3.12-slim AS builder
WORKDIR /app
COPY requirements.txt .
RUN pip install --user --no-cache-dir -r requirements.txt

FROM python:3.12-slim
WORKDIR /app
COPY --from=builder /root/.local /root/.local
COPY . .
ENV PATH=/root/.local/bin:$PATH
USER 1000
CMD ["python", "app.py"]
```
**Approx size:** ~150-200MB

---

## Example 3: Java (Spring Boot) — Unoptimized vs Optimized

### ❌ Unoptimized
```dockerfile
FROM maven:3.9-eclipse-temurin-21
WORKDIR /app
COPY . .
RUN mvn clean package
CMD ["java", "-jar", "target/app.jar"]
```
**Problems:**
- Ships the entire Maven + JDK toolchain in production image (~700MB+)
- No separation between build and runtime

**Approx size:** ~700-900MB

### ✅ Optimized (Multi-Stage)
```dockerfile
FROM maven:3.9-eclipse-temurin-21 AS builder
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline
COPY src ./src
RUN mvn clean package -DskipTests

FROM eclipse-temurin:21-jre-alpine
WORKDIR /app
COPY --from=builder /app/target/*.jar app.jar
USER 1000
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
```
**Approx size:** ~180-250MB

---

## Example 4: Nginx Static Site — Unoptimized vs Optimized

### ❌ Unoptimized
```dockerfile
FROM ubuntu:22.04
RUN apt-get update && apt-get install -y nginx
COPY index.html /var/www/html/
CMD ["nginx", "-g", "daemon off;"]
```
**Approx size:** ~180-220MB

### ✅ Optimized
```dockerfile
FROM nginx:1.27-alpine
COPY index.html /usr/share/nginx/html/index.html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
```
**Approx size:** ~40-45MB

---

## Summary Table — Size Reduction Impact

| Language/Stack | Unoptimized | Optimized | Reduction |
|---|---|---|---|
| Node.js | ~1.0GB | ~150MB | ~85% |
| Python | ~950MB | ~180MB | ~81% |
| Java (Spring Boot) | ~800MB | ~220MB | ~72% |
| Nginx | ~200MB | ~42MB | ~79% |

## Real-World Impact (AWS Context)
- Faster **ECR push/pull** during CI/CD (Jenkins/GitHub Actions → ECR → EKS)
- Faster **EKS pod scheduling** especially during scale-out events
- Reduced **EC2/EBS storage** costs for image caching on nodes
- Lower **data transfer costs** between CodeBuild/Jenkins and ECR
