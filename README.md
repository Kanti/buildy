# kanti/buildy

Small PHP Docker image (Alpine) for CI builds.

```sh
docker run --rm -v "$PWD":/app -w /app kanti/buildy:8.5 composer install
```

## Tags

`8.2` · `8.3` · `8.4` · `8.5` · `8.6` · `latest` (= 8.5)

Rebuilt daily, also tagged as `<version>-YYYY-MM-DD`. `8.6` is built from the release candidate until PHP 8.6 is released.

## Included

- **PHP extensions:** pcov, gd, pdo_mysql, pdo_sqlite, mysqli, soap, zip, intl, calendar
- **Tools:** git, composer 2, imagemagick, docker cli + compose, bash, jq, rsync, openssh, unzip, patch, file
- `memory_limit=-1`

Every image is smoke-tested against this list before it is pushed.
