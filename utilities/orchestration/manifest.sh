#!/bin/bash

#echo on
set -x

helm \
get \
manifest \
${APP_DEVELOPMENT_NAME}