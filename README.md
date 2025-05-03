# DocChat Self-Hosted

## Prerequisites

- Server with following requirements:
    - Ubuntu 22.04
    - 4GB RAM
    - 2 CPU Cores
    - 20GB Disk Space
- Docker
- Docker Compose
- Git
- htpasswd

## Setup Instructions

1. Clone this repo with deploy key

```
GIT_SSH_COMMAND='ssh -i ~/.ssh/github-clone-docchat -o IdentitiesOnly=yes' git clone git@github.com:apf-docchat/selfhosted.git $HOME/pw-stack
cd $HOME/pw-stack
git config core.sshCommand "ssh -i ~/.ssh/github-clone-docchat -o IdentitiesOnly=yes"
```

2. Copy `.env.example` to `.env` and update the values

```shell
cp .env.example .env
```

3. Create data dirs

```shell
mkdir -p mounted_data/traefik/letsencrypt mounted_data/mysql mounted_data/mongodb mounted_data/redis mounted_data/appdata/orgs mounted_data/appdata/tempfiles
```

4. Create internal auth users file

```shell
touch config/internal_auth/internal-users.htpasswd
htpasswd -B config/internal_auth/internal-users.htpasswd admin
```

4. Copy and update `config/webapp/envconfig.json.example` to `config/webapp/envconfig.json`:

```shell
cp config/webapp/envconfig.json.example config/webapp/envconfig.json
```

5. Copy and update `config/botadmin/config.json.example` to `config/botadmin/config.json`:

```shell
cp config/botadmin/config.json.example config/botadmin/config.json
```

3. Start backing services

```shell
docker compose up -d mysql mongodb redis
```

4. Start all services `docker compose up -d`
