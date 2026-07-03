# Base Image
FROM ubuntu:24.04

# Maintainer
LABEL maintainer="Nagesh"

# Install Packages
RUN apt-get update && \
    apt-get install -y curl wget vim && \
    apt-get clean

# Working Directory
WORKDIR /app

# Copy Files
COPY . .

# Default Command
CMD ["bash"]