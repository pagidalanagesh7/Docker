# ---- Stage 1: Build with Maven ----
FROM maven:3.9-eclipse-temurin-21 AS builder

WORKDIR /app

# Copy only pom.xml first to leverage dependency caching
COPY pom.xml .
RUN mvn dependency:go-offline

# Copy source code and build
COPY src ./src
RUN mvn clean package -DskipTests

# ---- Stage 2: Minimal Runtime Image ----
FROM eclipse-temurin:21-jre-alpine

WORKDIR /app

# Copy only the built JAR from builder stage
COPY --from=builder /app/target/*.jar app.jar

# Run as non-root user
RUN addgroup -S spring && adduser -S spring -G spring
USER spring

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]
