#!/bin/sh
if [ -z ${BASE_DIR} ]; then
    BASE_DIR=$(cd $(dirname $0)/..;pwd)
fi
if [ -z ${APP_NAME} ]; then
    APP_NAME=sample
fi
if [ ! -e ${BASE_DIR}/projects/${APP_NAME} ]; then
    mkdir -p ${BASE_DIR}/projects/${APP_NAME}
fi
docker run --user $(id -u):$(id -g) --rm -v ${BASE_DIR}/projects/${APP_NAME}:/app composer_php73:0.1 $@