#!/bin/bash

#echo on
set -x

docker \
    buildx \
    build \
    --file orchestration/service-discovery/Dockerfile \
    --tag ${APP_DEVELOPMENT_NAME}-service-discovery \
    --build-arg APP_DEVELOPMENT_NAME=${APP_DEVELOPMENT_NAME} \
    --build-arg SERVICE_DISCOVERY_FREQUENCY_MS=${SERVICE_DISCOVERY_FREQUENCY_MS} \
    .
