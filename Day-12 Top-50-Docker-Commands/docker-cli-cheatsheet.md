# Docker CLI Cheatsheet — Top 50 Commands

| # | Command | Purpose |
|---|---|---|
| 1 | `docker version` | Show Docker client/server version |
| 2 | `docker info` | Show system-wide Docker info |
| 3 | `docker build -t <name>:<tag> .` | Build image from Dockerfile |
| 4 | `docker images` | List local images |
| 5 | `docker image inspect <image>` | Show image metadata |
| 6 | `docker image history <image>` | Show image layer history |
| 7 | `docker tag <src> <dst>` | Tag an image |
| 8 | `docker pull <image>` | Pull image from registry |
| 9 | `docker push <image>` | Push image to registry |
| 10 | `docker rmi <image>` | Remove an image |
| 11 | `docker run <image>` | Run a new container |
| 12 | `docker run -d <image>` | Run container in detached mode |
| 13 | `docker run -it <image> bash` | Run interactive container with shell |
| 14 | `docker run -p 8080:80 <image>` | Map host port to container port |
| 15 | `docker run -v /host:/container <image>` | Bind mount a volume |
| 16 | `docker run --env-file .env <image>` | Pass env vars from file |
| 17 | `docker run --name <name> <image>` | Assign a container name |
| 18 | `docker run --restart=always <image>` | Set restart policy |
| 19 | `docker ps` | List running containers |
| 20 | `docker ps -a` | List all containers (incl. stopped) |
| 21 | `docker stop <container>` | Gracefully stop a container |
| 22 | `docker start <container>` | Start a stopped container |
| 23 | `docker restart <container>` | Restart a container |
| 24 | `docker kill <container>` | Force-kill a container |
| 25 | `docker rm <container>` | Remove a container |
| 26 | `docker exec -it <container> bash` | Open shell inside running container |
| 27 | `docker logs <container>` | View container logs |
| 28 | `docker logs -f <container>` | Stream container logs |
| 29 | `docker inspect <container>` | Show detailed container/image JSON |
| 30 | `docker stats` | Live resource usage of containers |
| 31 | `docker top <container>` | Show running processes in container |
| 32 | `docker cp <container>:/path ./local` | Copy files from container to host |
| 33 | `docker diff <container>` | Show filesystem changes in container |
| 34 | `docker commit <container> <image>` | Create image from container state |
| 35 | `docker volume create <name>` | Create a named volume |
| 36 | `docker volume ls` | List volumes |
| 37 | `docker volume inspect <name>` | Inspect volume details |
| 38 | `docker volume rm <name>` | Remove a volume |
| 39 | `docker network ls` | List networks |
| 40 | `docker network create <name>` | Create custom network |
| 41 | `docker network inspect <name>` | Inspect network details |
| 42 | `docker network connect <net> <container>` | Attach container to network |
| 43 | `docker compose up -d` | Start services from compose file |
| 44 | `docker compose down` | Stop and remove compose services |
| 45 | `docker compose logs -f` | Stream logs from all compose services |
| 46 | `docker login <registry>` | Authenticate to a registry |
| 47 | `docker system df` | Show Docker disk usage |
| 48 | `docker system prune -a` | Remove unused data (aggressive) |
| 49 | `docker container prune` | Remove all stopped containers |
| 50 | `docker save -o file.tar <image>` | Export image to tar archive |

> Tip: Pair this sheet with `real-time-scenarios.md` to see these commands used in actual debugging situations.
