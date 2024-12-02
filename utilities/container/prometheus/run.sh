#!/bin/bash

set -x #echo on

docker \
    run \
    --name ${APP_DEVELOPMENT_NAME}-prometheus \
    --detach \
    --publish ${DASHBOARD_NODE_PORT}:${DASHBOARD_CONTAINER_PORT} \
    --volume thrasos:/prometheus \
    ${APP_DEVELOPMENT_NAME}-prometheus