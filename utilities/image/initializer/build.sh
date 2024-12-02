#!/bin/bash

#echo on
set -x

docker \
    buildx \
    build \
    --file orchestration/initializer/Dockerfile \
    --tag ${APP_DEVELOPMENT_NAME}-initializer \
    .
