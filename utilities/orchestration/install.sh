#!/bin/bash

#echo on
set -x

helm \
install \
${APP_DEVELOPMENT_NAME} \
orchestration \
--set APP_VERSION=${APP_VERSION} \
--set APP_DEVELOPMENT_NAME=${APP_DEVELOPMENT_NAME} \
--set APP_PRODUCTION_NAME=${APP_PRODUCTION_NAME} \
--set DASHBOARD_CONTAINER_PORT=${DASHBOARD_CONTAINER_PORT} \
--set DASHBOARD_POD_PORT=${DASHBOARD_POD_PORT} \
--set DASHBOARD_NODE_PORT=${DASHBOARD_NODE_PORT} \
--set IMAGE_REGISTRY=${IMAGE_REGISTRY} \
--set ENVIRONMENT=${ENVIRONMENT} 