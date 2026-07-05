# 🐳 Docker Learning Series – Day 5
# Docker Networking

> A complete beginner-to-intermediate guide to Docker Networking with architecture, commands, examples, best practices, and interview questions.

---

# Table of Contents

1. Introduction
2. What is Docker Networking?
3. How Docker Networking Works
4. Docker Network Drivers
5. Bridge Network
6. Host Network
7. None Network
8. Overlay Network
9. Macvlan Network
10. Port Mapping
11. Docker DNS & Service Discovery
12. Docker Network Commands
13. Production Best Practices
14. Summary
15. Top 15 Interview Questions & Answers

---

# 1. Introduction

Containers rarely run alone.

A typical application consists of multiple services like:

```
Frontend
    │
Backend API
    │
Database
    │
Redis
```

These containers must communicate securely.

Docker Networking provides the communication layer that allows containers to talk to each other and also communicate with external systems.

Without networking:

- Containers cannot communicate
- Applications cannot expose services
- Databases cannot be reached
- APIs cannot serve requests

Docker Networking solves all these problems.

---

# 2. What is Docker Networking?

Docker Networking is the mechanism that allows containers to communicate with:

- Other containers
- Host machine
- Internet
- External systems

It also provides:

- Network Isolation
- Security
- Service Discovery
- Automatic DNS
- Port Forwarding

---

## Architecture

```
                 Internet
                     │
             Host Machine
                     │
             Docker Engine
                     │
             Docker Network
          ┌──────┼──────┐
          │      │      │
   Container A Container B Container C
```

---

## Benefits

✔ Container communication

✔ Secure isolation

✔ Automatic DNS

✔ Service discovery

✔ External connectivity

✔ Multi-host communication

---

# 3. How Docker Networking Works

Whenever Docker starts, it creates a default bridge network.

Every container gets:

- Private IP Address
- Network Interface (eth0)
- Gateway
- DNS Configuration

Example

```
Container A

IP:
172.17.0.2

Gateway:
172.17.0.1
```

Docker creates a Linux bridge called:

```
docker0
```

This bridge connects all containers.

---

# 4. Docker Network Drivers

Docker supports multiple networking modes.

---

## 1. Bridge

Default network driver.

Works only on one host.

```
Container A
      │
 docker0
      │
Container B
```

Features

- Default network
- NAT enabled
- Private subnet
- Supports DNS
- Secure communication

Use Cases

- Most applications
- Development
- Backend services

Command

```bash
docker network ls
```

---

## 2. Host Network

Container shares the host's network stack.

```
Host Network

Container

(No isolation)
```

Characteristics

- No NAT
- No bridge
- High performance
- Uses host ports directly

Example

```bash
docker run --network host nginx
```

Advantages

- Fast networking
- Low latency

Disadvantages

- No isolation
- Port conflicts

Best For

- Monitoring tools
- Performance-sensitive applications

---

## 3. None Network

Container has no network.

```
Container

No IP

No Internet

No DNS
```

Command

```bash
docker run --network none ubuntu
```

Use Cases

- Security testing
- Offline containers
- Complete isolation

---

## 4. Overlay Network

Overlay network connects containers running on multiple Docker hosts.

Used in:

Docker Swarm

Architecture

```
Host A
Container A
      │
Overlay
      │
Container B
Host B
```

Features

- Multi-host networking
- VXLAN tunnel
- Encrypted communication

Command

```bash
docker network create \
-d overlay app-network
```

Best For

- Docker Swarm
- Multi-node clusters

---

## 5. Macvlan Network

Macvlan gives containers their own MAC Address.

The container behaves like a physical machine.

```
Router
   │
Switch
   │
Container

Own IP

Own MAC
```

Advantages

- Direct LAN access
- Better compatibility
- Legacy applications

Command

```bash
docker network create \
-d macvlan \
--subnet=192.168.1.0/24 \
--gateway=192.168.1.1 \
-o parent=eth0 macvlan-net
```

Best For

- Legacy applications
- Network appliances

---

# Driver Comparison

| Driver | Scope | NAT | Performance | Use Case |
|----------|-----------|------|-------------|-------------|
| Bridge | Single Host | Yes | Medium | Default |
| Host | Host | No | High | Monitoring |
| None | None | No | N/A | Isolation |
| Overlay | Multi Host | Yes | Medium | Swarm |
| Macvlan | LAN | No | High | Legacy Apps |

---

# 5. Bridge Network

Bridge is Docker's default network.

When Docker is installed:

```
docker0
```

is automatically created.

Architecture

```
Container A
      │
docker0
      │
Container B
      │
Host NIC
      │
Internet
```

Inspect

```bash
docker network inspect bridge
```

Example Output

```json
{
 "Driver":"bridge",
 "Subnet":"172.17.0.0/16",
 "Gateway":"172.17.0.1"
}
```

---

# User-defined Bridge Network

Recommended over default bridge.

Create

```bash
docker network create app-network
```

Run

```bash
docker run -d \
--network app-network \
--name backend nginx
```

Advantages

- Automatic DNS
- Better isolation
- Easier communication
- Production ready

---

# 6. Port Mapping

Containers use internal ports.

External users cannot access them directly.

Port mapping exposes container ports.

Architecture

```
Browser

↓

localhost:8080

↓

Docker Engine

↓

Container

↓

Port 80
```

Command

```bash
docker run -d \
-p 8080:80 \
nginx
```

Meaning

```
Host Port : Container Port

8080 : 80
```

Access

```
http://localhost:8080
```

Output

```
Welcome to nginx!
```

---

## Multiple Port Mapping

```bash
docker run \
-p 8080:80 \
-p 8443:443 \
nginx
```

---

# 7. Docker DNS

Docker provides an internal DNS server.

Containers communicate using names instead of IPs.

Example

```
frontend

↓

backend

↓

database
```

Instead of

```
172.18.0.2
```

Simply use

```
backend
```

Ping

```bash
docker exec -it frontend ping backend
```

Output

```
PING backend (172.18.0.2)

64 bytes from backend

0% packet loss
```

Advantages

- No hardcoded IPs
- Automatic service discovery
- Easier maintenance

---

# 8. Docker Network Commands

## List Networks

```bash
docker network ls
```

---

## Inspect Network

```bash
docker network inspect bridge
```

---

## Create Network

```bash
docker network create app-network
```

---

## Connect Container

```bash
docker network connect app-network nginx
```

---

## Disconnect

```bash
docker network disconnect app-network nginx
```

---

## Remove Network

```bash
docker network rm app-network
```

---

## Show Port Mapping

```bash
docker port nginx
```

---

## Inspect Container

```bash
docker inspect nginx
```

---

# 9. Production Best Practices

✅ Use user-defined bridge networks

✅ Expose only required ports

✅ Never expose database ports publicly

✅ Use Docker DNS

✅ Remove unused networks

✅ Separate frontend/backend/database

✅ Inspect networks regularly

✅ Use Overlay for Swarm only

✅ Avoid Host mode unless necessary

✅ Use firewall rules

---

# 10. Common Networking Problems

## Container cannot reach another container

Possible Causes

- Different networks
- Firewall
- Wrong container name

Solution

```bash
docker network inspect app-network
```

---

## Port Already in Use

Error

```
Bind for 0.0.0.0:80 failed
```

Solution

Use another port.

```
8080:80
```

---

## DNS Resolution Failed

Check

```bash
docker exec container ping backend
```

---

# 11. Summary

Docker Networking provides:

- Bridge Networking
- Host Networking
- None Networking
- Overlay Networking
- Macvlan Networking
- Port Mapping
- Docker DNS
- Service Discovery
- Secure Container Communication

For most applications, a **user-defined bridge network** is the recommended choice because it provides automatic DNS resolution and better isolation.

---

# Top 15 Docker Networking Interview Questions & Answers

## 1. What is Docker Networking?

**Answer:**

Docker Networking enables communication between containers, the host machine, and external networks. It provides network isolation, service discovery, and secure communication.

---

## 2. What is the default Docker network driver?

**Answer:**

The default network driver is **Bridge**.

Docker automatically creates the `bridge` network using the Linux `docker0` bridge interface.

---

## 3. What is the difference between the default Bridge network and a user-defined Bridge network?

**Answer:**

| Default Bridge | User-defined Bridge |
|----------------|---------------------|
| Manual communication | Automatic DNS |
| Limited isolation | Better isolation |
| Basic networking | Production-ready |
| No automatic name resolution | Container name resolution supported |

---

## 4. What is Port Mapping?

**Answer:**

Port mapping exposes a container's internal port to the host machine.

Example:

```bash
docker run -p 8080:80 nginx
```

Host Port: `8080`

Container Port: `80`

---

## 5. What is Docker DNS?

**Answer:**

Docker includes an embedded DNS server for user-defined networks. Containers can communicate using container names instead of IP addresses.

Example:

```bash
ping backend
```

---

## 6. Explain the Host network.

**Answer:**

In Host mode, the container shares the host's network stack. There is no NAT or network isolation, resulting in higher performance but increased risk of port conflicts.

---

## 7. What is the None network?

**Answer:**

The None network completely disables networking for a container. The container has no IP address, DNS, or internet connectivity.

---

## 8. What is an Overlay network?

**Answer:**

Overlay networks connect containers across multiple Docker hosts using VXLAN. They are primarily used with Docker Swarm.

---

## 9. What is Macvlan?

**Answer:**

Macvlan assigns a unique MAC and IP address to each container, allowing it to appear as a physical device on the local network.

---

## 10. What is NAT in Docker?

**Answer:**

NAT (Network Address Translation) translates traffic between host ports and container ports, enabling external access to containerized applications.

---

## 11. How do you list Docker networks?

**Answer:**

```bash
docker network ls
```

---

## 12. How do you inspect a Docker network?

**Answer:**

```bash
docker network inspect bridge
```

This command displays the driver, subnet, gateway, and connected containers.

---

## 13. Why is a user-defined Bridge network recommended?

**Answer:**

Because it provides:
- Automatic DNS resolution
- Better isolation
- Easier container communication
- Improved security
- Better production practices

---

## 14. What is the difference between EXPOSE and `-p`?

**Answer:**

| EXPOSE | `-p` |
|--------|------|
| Documentation only | Publishes the port |
| Does not expose externally | Makes the service accessible from the host |
| Defined in Dockerfile | Used with `docker run` |

---

## 15. Which Docker network driver should you use in production?

**Answer:**

It depends on the use case:

- **Bridge** → Single-host applications (most common)
- **Host** → High-performance workloads
- **Overlay** → Multi-host Docker Swarm deployments
- **Macvlan** → Legacy applications requiring direct LAN access
- **None** → Fully isolated or security-sensitive containers

---

# 🎯 Key Takeaways

- Docker networking enables secure communication between containers.
- **Bridge** is the default and most widely used network driver.
- Prefer **user-defined bridge networks** for production because they support automatic DNS and better isolation.
- Use **Port Mapping (`-p`)** to expose container services externally.
- Docker's built-in DNS lets containers communicate using names instead of IP addresses.
- Choose the appropriate network driver based on performance, isolation, and deployment requirements.