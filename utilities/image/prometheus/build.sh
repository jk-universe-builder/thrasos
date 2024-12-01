#!/bin/bash

#echo on
set -x

docker \
    buildx \
    build \
    --file orchestration/prometheus/Dockerfile \
    --tag ${APP_DEVELOPMENT_NAME}-prometheus \
    .
