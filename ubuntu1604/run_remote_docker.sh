#!/bin/bash

source build.cfg

# Function: log messages
log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1"
}

# Function: check command return status
utils_check_ret() {
    if [ $1 -eq 0 ]; then
        echo "[INFO] $2 done!"
    else
        echo "[ERR] Failed on $2!"
        exit -1
    fi
}

# Pull remote image
log "Starting to pull remote image ${DOCKER_DEST}"
docker pull ${DOCKER_DEST}
utils_check_ret $? "Image pull"

# Run container
log "Starting to run the container"
docker run -ti \
    --privileged \
    -v "$PWD:${HOME}/work" \
    -e LOCAL_UID=$(id -u $USER) \
    -e LOCAL_GID=$(id -g $USER) \
    -w ${HOME}/work \
    --rm ${DOCKER_DEST}
utils_check_ret $? "Container run"
