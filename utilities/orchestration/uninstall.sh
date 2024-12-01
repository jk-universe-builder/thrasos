#!/bin/bash

#echo on
set -x

helm \
uninstall \
${APP_DEVELOPMENT_NAME}