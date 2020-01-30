#!/bin/sh
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
if [ ! -e ${BASE_DIR}/composer_cache ]; then
    mkdir -p ${BASE_DIR}/composer_cache
fi

docker run \
    --rm \
    --user $(id -u):$(id -g) \
    -v ${BASE_DIR}/projects/${APP_NAME}:/app \
    -v $(pwd)/composer_cache:/composer/cache \
    composer/composer $@
