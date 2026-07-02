````markdown
# 🐳 Docker Day 02 – Installing Docker & Running Your First Container

Welcome to **Day 02** of my **Docker in 10 Days** learning series.

In this chapter, you'll learn how to install Docker on Windows, macOS, and Linux, verify the installation, run your first container, and understand the basic Docker workflow.

---

# 📚 Topics Covered

- Docker Installation
- Docker Desktop vs Docker Engine
- Installing Docker on Windows
- Installing Docker on macOS
- Installing Docker on Ubuntu/Linux
- Verify Docker Installation
- Running Your First Container
- Essential Docker Commands
- Running Nginx
- Port Mapping
- Docker Container Lifecycle
- Sample Dockerfile

---

# 🖥️ Docker Installation

## 🪟 Windows (Docker Desktop)

### Prerequisites

- Windows 10/11 (64-bit)
- WSL 2 Enabled
- Virtualization Enabled in BIOS

### Installation Steps

1. Download Docker Desktop.
2. Run the installer.
3. Enable **Use WSL 2 instead of Hyper-V** (Recommended).
4. Restart your system if prompted.
5. Launch Docker Desktop.
6. Wait until Docker Engine starts.

### Verify Installation

```bash
docker --version
docker version
docker info
```

---

## 🍎 macOS (Docker Desktop)

### Prerequisites

- macOS 12 or later
- Intel or Apple Silicon (M1/M2/M3)

### Installation Steps

1. Download Docker Desktop for macOS.
2. Open the downloaded `.dmg` file.
3. Drag Docker into the **Applications** folder.
4. Launch Docker Desktop.
5. Allow the required permissions.
6. Wait until Docker Engine starts.

### Verify Installation

```bash
docker --version
docker version
docker info
```

---

## 🐧 Ubuntu / Linux

### Update Packages

```bash
sudo apt update
```

### Install Docker

```bash
sudo apt install docker.io -y
```

### Start Docker Service

```bash
sudo systemctl start docker
```

### Enable Docker on Boot

```bash
sudo systemctl enable docker
```

### Check Docker Status

```bash
sudo systemctl status docker
```

### Verify Installation

```bash
docker --version
docker version
docker info
```

### (Optional) Run Docker Without sudo

```bash
sudo usermod -aG docker $USER
newgrp docker
```

Test it:

```bash
docker run hello-world
```

---

# ✅ Verify Docker Installation

Run the following commands:

```bash
docker --version
docker version
docker info
```

Example Output

```text
Docker version 28.x.x
```

---

# 🚀 Run Your First Container

```bash
docker run hello-world
```

Expected Output

```text
Hello from Docker!

This message shows that your installation appears to be working correctly.
```

---

# 📦 Essential Docker Commands

## List Images

```bash
docker images
```

## List Running Containers

```bash
docker ps
```

## List All Containers

```bash
docker ps -a
```

## Start a Container

```bash
docker start <container_id>
```

## Stop a Container

```bash
docker stop <container_id>
```

## Restart a Container

```bash
docker restart <container_id>
```

## Remove a Container

```bash
docker rm <container_id>
```

## View Logs

```bash
docker logs <container_id>
```

## Execute Commands Inside a Container

```bash
docker exec -it <container_id> bash
```

---

# 🌐 Running an Nginx Container

Pull and run the official Nginx image.

```bash
docker run -d -p 8080:80 nginx
```

Open your browser and visit:

```text
http://localhost:8080
```

You should see the default **Welcome to nginx!** page.

---

# 🔄 Docker Container Lifecycle

```text
Docker Image
      │
      ▼
Container Created
      │
      ▼
Running
      │
      ▼
Stopped
      │
      ▼
Removed
```

---

# 📝 Sample Dockerfile

Create a file named **Dockerfile**

```dockerfile
FROM ubuntu:24.04

LABEL author="Nagesh"
LABEL project="Docker Day 02"

RUN apt update && \
    apt install -y curl

CMD ["echo", "Hello from my first Dockerfile! 🐳"]
```

---

# 🔨 Build Docker Image

```bash
docker build -t my-first-image .
```

---

# ▶️ Run Docker Image

```bash
docker run my-first-image
```

Expected Output

```text
Hello from my first Dockerfile! 🐳
```

---

# 📂 Project Structure

```text
Day-02-Docker-Installation/
│
├── README.md
├── Dockerfile
├── commands.md
├── screenshots/
└── assets/
```

---

# 🎯 Learning Outcomes

After completing Day 02, you should be able to:

- ✅ Install Docker on Windows, macOS, and Linux
- ✅ Verify Docker installation
- ✅ Run your first Docker container
- ✅ Understand the Docker container lifecycle
- ✅ Use essential Docker commands
- ✅ Run a web application inside a container
- ✅ Build and run a simple Docker image

---

# 📸 Screenshots

Add screenshots for the following:

- Docker Desktop
- `docker --version`
- `docker info`
- `docker run hello-world`
- `docker images`
- `docker ps`
- Nginx running in the browser

---

# 📖 Next Day

➡️ **Docker Day 03 – Docker Images & Image Lifecycle**

Stay tuned as we explore Docker Images, Layers, Image Management, and Docker Hub.

---

⭐ **If you found these notes helpful, don't forget to Star this repository and follow my Docker in 10 Days journey!**
````
