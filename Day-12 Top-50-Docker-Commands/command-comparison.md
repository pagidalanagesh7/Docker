# Commonly Confused Docker Commands

## `docker stop` vs `docker kill`
| | `docker stop` | `docker kill` |
|---|---|---|
| Signal | SIGTERM, then SIGKILL after grace period | SIGKILL immediately |
| Graceful shutdown | Yes | No |
| Use case | Normal operations | Unresponsive container |

## `docker rm` vs `docker rm -f`
| | `docker rm` | `docker rm -f` |
|---|---|---|
| Works on running container | No (error) | Yes (force-kills first) |
| Recommended flow | Stop, then remove | Only when you're certain force is safe |

## `docker exec` vs `docker run`
| | `docker exec` | `docker run` |
|---|---|---|
| Target | Existing running container | Creates a brand-new container |
| Use case | Debug/inspect live container | Start a fresh instance |

## `docker cp` vs volume mount
| | `docker cp` | Volume/bind mount |
|---|---|---|
| Persistence | One-time copy, not synced | Live, persists across restarts |
| Use case | Quick file grab/drop | Ongoing shared/persistent data |

## `docker images -a` vs `docker images`
| | `docker images` | `docker images -a` |
|---|---|---|
| Shows | Top-level tagged images | Includes intermediate build-layer images |

## `docker system prune` vs `docker system prune -a`
| | `prune` | `prune -a` |
|---|---|---|
| Images removed | Only dangling (untagged) | All unused images, even tagged ones not in use |
| Risk level | Low | Higher — can remove images you meant to keep for later |

## `docker network` default `bridge` vs user-defined bridge
| | Default `bridge` | User-defined bridge |
|---|---|---|
| DNS by container name | No | Yes |
| Isolation | Shared flat network | Better isolated, one network per app |
| Recommended for multi-container apps | No | Yes |

## `docker save`/`load` vs `docker export`/`import`
| | `save` / `load` | `export` / `import` |
|---|---|---|
| Operates on | Images (with layers, history, metadata) | Containers (flattened filesystem snapshot, no layer history) |
| Use case | Move an image between hosts/registries | Snapshot a container's filesystem as a new base image |

## `docker compose exec` vs `docker compose run`
| | `exec` | `run` |
|---|---|---|
| Target | Already-running service container | Starts a new one-off container from the service spec |
| Use case | Shell into running app | Run a migration/script without affecting the running service |

## `docker volume prune` vs `docker volume rm`
| | `prune` | `rm <name>` |
|---|---|---|
| Scope | All unused volumes at once | One specific volume |
| Safety | Riskier — no per-volume confirmation | Safer, explicit |
