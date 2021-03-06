#!/bin/sh
if [ -z ${BASE_DIR} ]; then
  BASE_DIR=$(cd $(dirname $0)/..;pwd)
fi

cd ${BASE_DIR}
if [ ! -e $(pwd)/projects ]; then
  mkdir -p $(pwd)/projects
fi
if [ ! -e $(pwd)/composer_cache ]; then
  mkdir -p $(pwd)/composer_cache
fi

docker run --user $(id -u):$(id -g) --rm -v $(pwd)/projects:/app -v $(pwd)/composer_cache:/composer/cache composer/composer $@
