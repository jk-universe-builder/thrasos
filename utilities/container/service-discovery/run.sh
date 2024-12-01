#!/bin/bash

set -x #echo on

docker \
    run \
    --name ${APP_DEVELOPMENT_NAME}-service-discovery \
    --detach \
    --volume thrasos:/prometheus \
    ${APP_DEVELOPMENT_NAME}-service-discovery