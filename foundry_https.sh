#!/bin/bash

basedir=$(dirname "$0")

up() {
    docker-compose -f $basedir/docker-compose-https.yml -f $basedir/docker-compose-https.override.yml up -d
}

down() {
    docker-compose -f $basedir/docker-compose-https.yml -f $basedir/docker-compose-https.override.yml down
}

case "$1" in
    up)
        up
        ;;
    down)
        down
        ;;
    *)
        echo "Usage: foundry-https { up | down }"
esac
