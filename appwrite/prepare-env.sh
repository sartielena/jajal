#!/bin/sh

set -e

if [ ! -z "$MYSQL_URL" ]; then
  export _APP_DB_HOST=$(php -r 'echo parse_url(getenv("MYSQL_URL"), PHP_URL_HOST);')
  export _APP_DB_PORT=$(php -r 'echo parse_url(getenv("MYSQL_URL"), PHP_URL_PORT);')
  export _APP_DB_USER=$(php -r 'echo parse_url(getenv("MYSQL_URL"), PHP_URL_USER);')
  export _APP_DB_PASS=$(php -r 'echo parse_url(getenv("MYSQL_URL"), PHP_URL_PASS);')
  export _APP_DB_SCHEMA=$(php -r 'echo substr(parse_url(getenv("MYSQL_URL"), PHP_URL_PATH), 1);')
fi

if [ ! -z "$REDIS_URL" ]; then
  export _APP_REDIS_HOST=$(php -r 'echo parse_url(getenv("REDIS_URL"), PHP_URL_HOST);')
  export _APP_REDIS_PORT=$(php -r 'echo parse_url(getenv("REDIS_URL"), PHP_URL_PORT);')
  export _APP_REDIS_USER=$(php -r 'echo parse_url(getenv("REDIS_URL"), PHP_URL_USER);')
  export _APP_REDIS_PASS=$(php -r 'echo parse_url(getenv("REDIS_URL"), PHP_URL_PASS);')
fi

# some sane default for Heroku environments
export _APP_WORKER_PER_CORE=${_APP_WORKER_PER_CORE:-'1'}

env | grep _APP_ | grep -v PASS | sort

exec "$@"
