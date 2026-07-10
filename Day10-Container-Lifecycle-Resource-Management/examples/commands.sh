#!/bin/bash
# Day 10 - Docker Container Lifecycle & Resource Management
# Quick command reference / demo script

set -e

echo "== Build image =="
docker build -t day10-demo:latest .

echo "== Run with restart policy + resource limits =="
docker run -d \
  --name day10-demo \
  --restart=unless-stopped \
  --cpus=1 \
  --memory=256m \
  -p 8080:80 \
  day10-demo:latest

echo "== Check container status (look for healthy/unhealthy) =="
sleep 6
docker ps --filter "name=day10-demo"

echo "== Live resource usage =="
docker stats --no-stream day10-demo

echo "== Graceful stop (SIGTERM -> SIGKILL after timeout) =="
docker stop -t 10 day10-demo

echo "== Cleanup =="
docker rm day10-demo
docker container prune -f
