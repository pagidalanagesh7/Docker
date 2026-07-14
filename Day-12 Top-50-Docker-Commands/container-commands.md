# Docker Container Commands

## Run

```bash
docker run nginx                                   # foreground
docker run -d nginx                                 # detached (background)
docker run -it ubuntu bash                           # interactive shell
docker run -d -p 8080:80 --name web nginx             # port map + named
docker run -d -v appdata:/var/lib/app nginx            # named volume mount
docker run -d --env-file .env myapp                     # env vars from file
docker run -d --restart=always myapp                     # auto-restart policy
docker run -d --memory=512m --cpus=1 myapp                # resource limits
```

Restart policies: `no` (default), `on-failure[:max-retries]`, `always`, `unless-stopped`.

## Lifecycle

```bash
docker start web
docker stop web              # sends SIGTERM, waits, then SIGKILL
docker stop -t 30 web        # custom grace period (seconds)
docker restart web
docker kill web               # immediate SIGKILL
docker pause web
docker unpause web
docker rm web
docker rm -f web               # force remove running container
```

## Inspect & Debug

```bash
docker ps                     # running containers
docker ps -a                  # all containers
docker ps -f status=exited     # filter by status
docker logs web
docker logs -f --tail 100 web   # stream last 100 lines live
docker inspect web               # full JSON metadata
docker top web                    # processes inside container
docker stats web                   # live CPU/mem/network usage
docker diff web                     # filesystem changes vs image
```

## Exec Into a Running Container

```bash
docker exec -it web bash
docker exec -it web sh          # for minimal images without bash
docker exec web env               # run a one-off command
```

## Copy Files

```bash
docker cp web:/var/log/app.log ./app.log
docker cp ./config.yaml web:/etc/app/config.yaml
```

## Commit (create image from container state)

```bash
docker commit web myapp:debug-snapshot
```

Useful for capturing a container's exact state during debugging, though not a substitute for a proper Dockerfile-based build.
