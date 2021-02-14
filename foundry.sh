#!/bin/bash

basedir=$(dirname "$0")

up() {
    docker-compose -f $basedir/docker-compose.yml up -d
}

stop() {
    docker-compose -f $basedir/docker-compose.yml stop
}

down() {
    docker-compose -f $basedir/docker-compose.yml down
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
        echo "Usage: foundry { up | stop | down}"
esac
