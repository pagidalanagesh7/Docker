# Docker Networking Examples

## Example 1: Create a Custom Network

```bash
docker network create app-network
```

Output

```text
9d4d2abf5eaf9c9f...
```

---

## Example 2: Run Nginx Container

```bash
docker run -d \
--name web \
--network app-network \
-p 8080:80 \
nginx
```

Output

```text
b13d5e1a8d9f...
```

Access

```
http://localhost:8080
```

---

## Example 3: Run Ubuntu Container

```bash
docker run -dit \
--name app \
--network app-network \
ubuntu
```

Output

```text
c72b1d90f3aa...
```

---

## Example 4: Verify DNS Resolution

```bash
docker exec -it app bash
```

Inside the container:

```bash
apt update
apt install -y iputils-ping

ping web
```

Output

```text
PING web (172.18.0.2)

64 bytes from 172.18.0.2

64 bytes from 172.18.0.2

0% packet loss
```

---

## Example 5: Inspect Network

```bash
docker network inspect app-network
```

Output

```json
{
  "Name": "app-network",
  "Driver": "bridge",
  "IPAM": {
    "Subnet": "172.18.0.0/16",
    "Gateway": "172.18.0.1"
  }
}
```

---

## Example 6: Display Port Mapping

```bash
docker port web
```

Output

```text
80/tcp -> 0.0.0.0:8080
```

---

## Example 7: List Docker Networks

```bash
docker network ls
```

Output

```text
NETWORK ID     NAME          DRIVER
8f21ad3c91     bridge        bridge
bc11de9a52     host          host
aa23fe65cd     none          null
cf34ab67ef     app-network   bridge
```

---

## Example 8: Remove Custom Network

```bash
docker network rm app-network
```

Output

```text
app-network
```