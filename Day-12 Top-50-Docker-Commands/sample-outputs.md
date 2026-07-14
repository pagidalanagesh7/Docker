# Sample Terminal Outputs

## `docker ps`
```
CONTAINER ID   IMAGE          COMMAND                  STATUS          PORTS                  NAMES
a1b2c3d4e5f6   nginx:1.25     "/docker-entrypoint.…"   Up 2 hours      0.0.0.0:8080->80/tcp   web
f6e5d4c3b2a1   postgres:16    "docker-entrypoint.s…"   Up 2 hours      5432/tcp               db
```

## `docker ps -a` (with an exited container)
```
CONTAINER ID   IMAGE      COMMAND         STATUS                      PORTS     NAMES
9f8e7d6c5b4a   myapp:1.0  "python app.py" Exited (1) 3 minutes ago              api
```

## `docker images`
```
REPOSITORY   TAG       IMAGE ID       CREATED        SIZE
myapp        1.0       3f4a2b1c9d8e   2 hours ago    186MB
nginx        1.25      a2c4e6f8b0d2   3 days ago     142MB
postgres     16        b1d3f5a7c9e1   1 week ago     412MB
<none>       <none>    d4e6a8c0f2b4   1 week ago     186MB
```
> The `<none>` entries are dangling images — safe candidates for `docker image prune`.

## `docker inspect <container>` (trimmed, key fields)
```json
{
    "State": {
        "Status": "exited",
        "Running": false,
        "ExitCode": 1,
        "OOMKilled": false,
        "StartedAt": "2026-07-14T09:12:03Z",
        "FinishedAt": "2026-07-14T09:12:05Z"
    },
    "RestartCount": 4,
    "Mounts": [
        {
            "Type": "volume",
            "Name": "appdata",
            "Destination": "/var/lib/app"
        }
    ]
}
```

## `docker stats` (live view snapshot)
```
CONTAINER ID   NAME   CPU %     MEM USAGE / LIMIT     MEM %     NET I/O           BLOCK I/O
a1b2c3d4e5f6   web    0.12%     18.4MiB / 512MiB      3.59%     1.2kB / 648B      0B / 0B
f6e5d4c3b2a1   db     1.85%     142MiB / 1GiB         13.9%     3.4kB / 2.1kB     12MB / 8MB
```

## `docker system df`
```
TYPE            TOTAL     ACTIVE    SIZE      RECLAIMABLE
Images          14        6         3.6GB     2.1GB (58%)
Containers      8         3         204MB     140MB (68%)
Local Volumes   6         4         1.2GB     380MB (31%)
Build Cache     51        0         1.4GB     1.4GB (100%)
```

## `docker logs -f web`
```
2026-07-14T09:00:01.223Z INFO  Starting nginx worker processes
2026-07-14T09:00:01.301Z INFO  Listening on 0.0.0.0:80
2026-07-14T09:04:12.887Z WARN  client sent invalid host header
2026-07-14T09:10:44.019Z INFO  200 GET /health 3ms
```

## `docker image history myapp:1.0`
```
IMAGE          CREATED         CREATED BY                                      SIZE
3f4a2b1c9d8e   2 hours ago     CMD ["python" "app.py"]                         0B
<missing>      2 hours ago     COPY . .                                        4.2MB
<missing>      2 hours ago     RUN pip install -r requirements.txt             98.6MB
<missing>      2 hours ago     COPY requirements.txt .                         1.1kB
<missing>      2 days ago      FROM python:3.12-slim                           83MB
```
> The `RUN pip install` layer is the largest — a good candidate to optimize with `--no-cache-dir` or a multi-stage build.
