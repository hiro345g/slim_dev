#!/bin/sh
if [ -z ${BASE_DIR} ]; then
    BASE_DIR=$(cd $(dirname $0);pwd)
fi
URL_BASE=https://raw.githubusercontent.com/composer/docker/47c6a2cc73d7c2c5593f72ed62456d997236c71f/1.9/

cd ${BASE_DIR}
for t in Dockerfile docker-entrypoint.sh
do
    curl -O -s "${URL_BASE}/${t}"
done

sed -i 's/7-alpine/7.3-alpine/' Dockerfile
docker-compose build
