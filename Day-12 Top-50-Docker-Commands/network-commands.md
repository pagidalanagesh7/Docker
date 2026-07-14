# Docker Network Commands

## List & Inspect

```bash
docker network ls
docker network inspect bridge
docker network inspect mynet
```

## Create

```bash
docker network create mynet                       # default bridge driver
docker network create --driver bridge mynet
docker network create --subnet 172.20.0.0/16 mynet
```

## Connect / Disconnect

```bash
docker network connect mynet web
docker network disconnect mynet web
```

## Remove

```bash
docker network rm mynet
docker network prune                # remove unused networks
```

## Network Drivers

| Driver | Use Case |
|---|---|
| `bridge` | Default, single-host container communication |
| `host` | Container shares host's network namespace directly (no isolation) |
| `none` | No networking |
| `overlay` | Multi-host networking (Docker Swarm) |
| `macvlan` | Assigns a MAC address, container appears as physical device on network |

## Common Patterns

```bash
# Run two containers on the same custom network so they can resolve
# each other by container name (Docker's embedded DNS)
docker network create appnet
docker run -d --name db --network appnet postgres
docker run -d --name api --network appnet myapi
# 'api' container can now reach the db at hostname 'db'
```

```bash
# Inspect which containers are attached to a network
docker network inspect appnet --format '{{json .Containers}}'
```

## Production Note

Default `bridge` network does **not** provide automatic DNS resolution between containers by container name — only user-defined networks do. Always create a custom network for multi-container apps instead of relying on the default bridge.
