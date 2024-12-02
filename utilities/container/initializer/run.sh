#!/bin/bash

set -x #echo on

docker \
    run \
    --name ${APP_DEVELOPMENT_NAME}-initializer \
    --detach \
    --volume thrasos:/prometheus \
    ${APP_DEVELOPMENT_NAME}-initializer