#!/bin/sh
if [ -z ${BASE_DIR} ]; then
    BASE_DIR=$(cd $(dirname $0)/..;pwd)
fi
if [ -z ${APP_NAME} ]; then
    APP_NAME_1=sample
else
    APP_NAME_1=${APP_NAME}
fi
APP_NAME=${APP_NAME_1} sh ${BASE_DIR}/tool/composer.sh require slim/slim:"3.*"

for d in public logs
do
    if [ ! -e ${BASE_DIR}/projects/${APP_NAME_1}/${d} ]; then
        mkdir -p ${BASE_DIR}/projects/${APP_NAME_1}/${d}
    fi
done

if [ -e ${BASE_DIR}/projects/${APP_NAME_1}/public/ ]; then
    cp ${BASE_DIR}/template/index.php ${BASE_DIR}/projects/${APP_NAME_1}/public/
fi
cp ${BASE_DIR}/template/docker-compose.yml ${BASE_DIR}/projects/${APP_NAME_1}/
