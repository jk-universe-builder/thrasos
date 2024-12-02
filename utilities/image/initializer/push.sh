#!/bin/bash
set -x #echo on

docker tag ${APP_DEVELOPMENT_NAME}-initializer ${IMAGE_REGISTRY}/${APP_DEVELOPMENT_NAME}-initializer
docker push ${IMAGE_REGISTRY}/${APP_DEVELOPMENT_NAME}-initializer