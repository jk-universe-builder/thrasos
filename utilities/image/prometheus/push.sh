#!/bin/bash
set -x #echo on

docker tag ${APP_DEVELOPMENT_NAME}-prometheus ${IMAGE_REGISTRY}/${APP_DEVELOPMENT_NAME}-prometheus
docker push ${IMAGE_REGISTRY}/${APP_DEVELOPMENT_NAME}-prometheus