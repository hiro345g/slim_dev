#!/bin/sh
if [ -z ${BASE_DIR} ]; then
    BASE_DIR=$(cd $(dirname $0)/..;pwd)
fi
if [ -z ${APP_NAME} ]; then
    APP_NAME=sample
fi

cd ${BASE_DIR}/projects/${APP_NAME}
docker-compose down
