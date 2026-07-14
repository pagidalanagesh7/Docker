# ---------------------------------------------------------
# Docker Learning Series - Day 11
# Production Ready Dockerfile
# ---------------------------------------------------------

# Use a lightweight official Python image
FROM python:3.12-slim

# Metadata
LABEL maintainer="Nagesh"
LABEL description="Production-ready Docker Troubleshooting Demo"
LABEL version="1.0"

# Prevent Python from writing .pyc files
ENV PYTHONDONTWRITEBYTECODE=1

# Disable stdout buffering
ENV PYTHONUNBUFFERED=1

# Create application directory
WORKDIR /app

# Copy dependency file first (better layer caching)
COPY requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy application files
COPY . .

# Create a non-root user
RUN useradd -m dockeruser

# Change ownership
RUN chown -R dockeruser:dockeruser /app

# Switch to non-root user
USER dockeruser

# Expose application port
EXPOSE 8080

# Health Check
HEALTHCHECK --interval=30s \
            --timeout=10s \
            --start-period=15s \
            --retries=3 \
CMD curl --fail http://localhost:8080 || exit 1

# Start Application
CMD ["python","app.py"]