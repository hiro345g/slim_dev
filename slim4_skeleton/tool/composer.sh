#!/bin/sh
if [ -z ${BASE_DIR} ]; then
    BASE_DIR=$(cd $(dirname $0)/..;pwd)
fi
if [ -z ${APP_NAME} ]; then
    APP_NAME=sample
fi

cd ${BASE_DIR}
docker run --user $(id -u):$(id -g) --rm -v $(pwd)/projects/${APP_NAME}:/app composer_php73:0.1 $@
