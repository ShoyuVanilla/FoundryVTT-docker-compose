#!/bin/bash

basedir=$(dirname "$0")

up() {
    docker-compose -f $basedir/docker-compose-https.yml -f $basedir/docker-compose-https.override.yml up -d
}

stop() {
    docker-compose -f $basedir/docker-compose-https.yml -f $basedir/docker-compose-https.override.yml stop
}

down() {
    docker-compose -f $basedir/docker-compose-https.yml -f $basedir/docker-compose-https.override.yml down
}

case "$1" in
    up)
        up
        ;;
    stop)
        stop
        ;;
    down)
        down
        ;;
    *)
        echo "Usage: foundry-https { up | stop | down}"
esac
