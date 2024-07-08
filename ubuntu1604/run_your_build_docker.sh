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

# Run container
log "Starting to run the container"
docker run \
    --cap-add NET_ADMIN \
    --hostname buildserver \
    -it \
    -v `pwd`:/home/build/work \
    yoctocontainer
utils_check_ret $? "Container run"
