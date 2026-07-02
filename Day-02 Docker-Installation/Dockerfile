# Use the official Ubuntu image
FROM ubuntu:24.04

# Maintainer information
LABEL author="Nagesh"
LABEL description="Docker Day 02 - My First Docker Image"

# Update packages and install curl
RUN apt update && \
    apt install -y curl && \
    apt clean

# Default command
CMD ["echo", "Hello from my first Docker Image! 🐳"]