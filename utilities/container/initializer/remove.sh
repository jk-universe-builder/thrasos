#!/bin/bash

set -x #echo on

docker container rm -f ${APP_DEVELOPMENT_NAME}-initializer
