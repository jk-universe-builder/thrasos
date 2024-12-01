#!/bin/bash
set -x #echo on

docker tag ${APP_DEVELOPMENT_NAME}-service-discovery ${IMAGE_REGISTRY}/${APP_DEVELOPMENT_NAME}-service-discovery
docker push ${IMAGE_REGISTRY}/${APP_DEVELOPMENT_NAME}-service-discovery