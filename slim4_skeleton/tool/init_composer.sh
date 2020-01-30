#!/bin/sh
if [ -z ${BASE_DIR} ]; then
    BASE_DIR=$(cd $(dirname $0)/..;pwd)
fi

cd ${BASE_DIR}
if [ ! -e $(pwd)/projects ]; then
    mkdir -p $(pwd)/projects
fi

docker run --user $(id -u):$(id -g) --rm -v $(pwd)/projects:/app composer_php73:0.1 $@