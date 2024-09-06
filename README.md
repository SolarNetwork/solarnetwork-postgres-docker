# SolarNetwork Developer Postgres Database Docker

This project contains a Docker configuration for a Postgres database instance
configured for SolarNetwork development. The container will be initialized with
two databases, owned by two database users:

| Owner       | Password    | Database                |
| :---------- | :---------- | :---------------------- |
| `solarnet`  | `solarnet`  | `solarnetwork`          |
| `solartest` | `solartest` | `solarnetwork_unittest` |

The database administrative user is `postgres` with password `postgres`.

# Building

You can use `make` with the following targets:

| Target    | Description                                          |
| :-------- | :--------------------------------------------------- |
| `build`   | Create the Docker image                              |
| `rebuild` | Create the Docker image, ignoring any cached layers. |
| `run`     | Launch the container                                 |
| `start`   | Start a previously stopped container                 |
| `stop`    | Stop a launched container                            |
| `remove`  | Remove the container.                                |

# Customize the Postgres port

By default Postgres will be listening on port `5432`. You can customize that
by passing `PORT=X` to the `run` target, like

```sh
make run PORT=1234
```

# Multi-platform build

You can use the `BUILD_OPTS` parameter to build a [multi-platform image][mp], like

```sh
make build BUILD_OPTS="--platform linux/amd64,linux/arm64"
```

[mp]: https://docs.docker.com/build/building/multi-platform/
