#!/bin/sh
if [ -z ${BASE_DIR} ]; then
    BASE_DIR=$(cd $(dirname $0);pwd)
fi

sh ${BASE_DIR}/build.sh

if [ ! -e ${HOME}/.local/bin/ ]; then
    mkdir ${HOME}/.local/bin
fi
cat > ${HOME}/.local/bin/composer << 'EOF'
#!/bin/sh
echo "Current directory: '"$(pwd)"'"
docker run --user $(id -u):$(id -g) --rm -v ${pwd}:/app composer_php73:0.1 $@
EOF

chmod +x ${HOME}/.local/bin/composer
