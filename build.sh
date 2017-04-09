#!/bin/bash

## Check prerequisites

if ! type  "curl" > /dev/null; then
    echo "Error: 'curl' command must be installed on the system.";
    exit
fi

if ! type "awk" > /dev/null; then
    echo "Error: 'awk' command must be installed on the system.";
    exit
fi

if ! type "docker" > /dev/null; then
    echo "Error: 'docker' command must be installed on the system.";
    exit
fi

if ! type "docker-compose" > /dev/null; then
    echo "Error: 'docker-compose' command must be installed on the system.";
    exit
fi

## Make sure environment variables are correctly set

if [ -z "$PA_VERSION" ]; then
    PA_VERSION="0.15.0"
fi

if [ -z "$PA_ADMIN_VERSION" ]; then
    PA_ADMIN_VERSION="0.15.0"
fi

if [ -z "$PA_PUSH_VERSION" ]; then
    PA_PUSH_VERSION="0.15.0-alpha"
fi

if [ -z "$MYSQL_VERSION" ]; then
    MYSQL_VERSION="5.1.41"
fi

if [ -z "$ALPN_BOOT_VERSION" ]; then
    ALPN_BOOT_VERSION="8.1.11.v20170118"
fi

export PA_VERSION
export PA_ADMIN_VERSION
export PA_PUSH_VERSION
export MYSQL_VERSION
export ALPN_BOOT_VERSION

## Launch build scripts

CURRENT_DIR=`pwd`

cd $CURRENT_DIR/docker-powerauth-mysql ; sh ./build.sh
cd $CURRENT_DIR/docker-powerauth-push-mysql ; sh ./build.sh
cd $CURRENT_DIR/docker-powerauth-java-server ; sh ./build.sh
cd $CURRENT_DIR/docker-powerauth-admin ; sh ./build.sh
cd $CURRENT_DIR/docker-powerauth-push-server ; sh ./build.sh

cd $CURRENT_DIR/
