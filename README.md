# DocChat Single Instance Stack

## Setup Instructions

- Create data  dirs
```shell
mkdir -p mounted_data/traefik/letsencrypt mounted_data/mysql mounted_data/mongodb mounted_data/redis
```

- Copy `.env.example` to `.env` and update the values
- Start backing services (`docker compose up -d mysql mongodb redis`)
- Start all services `docker compose up -d`
