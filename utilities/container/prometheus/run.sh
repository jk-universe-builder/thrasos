#!/bin/bash

set -x #echo on

docker \
    run \
    --name ${APP_DEVELOPMENT_NAME}-prometheus \
    --detach \
    --publish ${DASHBOARD_PORT}:${DASHBOARD_PORT} \
    --volume thrasos:/prometheus \
    ${APP_DEVELOPMENT_NAME}-prometheus