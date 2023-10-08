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

if [ ! -z "$S3_AWS_ACCESS_KEY_ID" ]; then
  export _APP_STORAGE_DEVICE="s3"
  export _APP_STORAGE_S3_ACCESS_KEY=$S3_AWS_ACCESS_KEY_ID
  export _APP_STORAGE_S3_SECRET=$S3_AWS_SECRET_ACCESS_KEY
  export _APP_STORAGE_S3_REGION=$S3_AWS_REGION
  export _APP_STORAGE_S3_BUCKET=$S3_BUCKET_NAME
fi

# some sane default for Heroku environments
export _APP_STORAGE_ANTIVIRUS=${_APP_STORAGE_ANTIVIRUS:-'disabled'}
export _APP_STORAGE_LIMIT=${_APP_STORAGE_LIMIT:-'10000000'}
export _APP_STORAGE_PREVIEW_LIMIT=${_APP_STORAGE_PREVIEW_LIMIT:-'20000000'}
export _APP_WORKER_PER_CORE=${_APP_WORKER_PER_CORE:-'1'}

# print prepared environment variables for verification
env |
  grep _APP_ |
  grep -v PASS |
  grep -v SECRET |
  sort

# disable OPcache because Redis->pconnect doesn't work on Heroku (no idea why)
rm -f /usr/local/etc/php/conf.d/docker-php-ext-opcache.ini

exec "$@"
