#!/bin/bash

basedir=$(dirname "$0")

up() {
    docker-compose -f $basedir/docker-compose.yml up -d
}

down() {
    docker-compose -f $basedir/docker-compose.yml down
}

case "$1" in
    up)
        up
        ;;
    down)
        down
        ;;
    *)
        echo "Usage: foundry { up | down }"
esac
