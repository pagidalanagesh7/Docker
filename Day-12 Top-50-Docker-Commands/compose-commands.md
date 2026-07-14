# Docker Compose Commands

## Core Lifecycle

```bash
docker compose up                 # start, attached (foreground)
docker compose up -d              # start, detached
docker compose up -d --build       # rebuild images before starting
docker compose down                 # stop and remove containers/networks
docker compose down -v               # also remove named volumes
docker compose stop
docker compose start
docker compose restart
```

## Inspect & Debug

```bash
docker compose ps
docker compose logs
docker compose logs -f api          # stream logs for one service
docker compose top
docker compose config                # validate and print resolved config
```

## Build & Scale

```bash
docker compose build
docker compose build --no-cache
docker compose up -d --scale api=3    # run 3 replicas of the 'api' service
```

## Exec Into a Service

```bash
docker compose exec api bash
docker compose run --rm api python manage.py migrate
```

`exec` runs inside an already-running container; `run` starts a new one-off container from the service definition (useful for migrations/scripts).

## Sample compose.yaml

```yaml
version: "3.9"
services:
  api:
    build: .
    ports:
      - "8080:8080"
    environment:
      - DB_HOST=db
    depends_on:
      - db
  db:
    image: postgres:16
    volumes:
      - dbdata:/var/lib/postgresql/data
volumes:
  dbdata:
```

## Production Note

`docker compose` (v2 syntax, no hyphen) is now the standard — the old `docker-compose` binary is deprecated. Use `-f` to point at environment-specific files: `docker compose -f compose.yaml -f compose.prod.yaml up -d`.
