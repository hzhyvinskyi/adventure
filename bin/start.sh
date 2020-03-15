#!/bin/sh

# shellcheck disable=SC2046
docker stop $(docker ps -a -q --format '{{.Names}}' | grep adventure_)
# shellcheck disable=SC2046
docker rm $(docker ps -a -q --format '{{.Names}}' | grep adventure_)

docker-compose up "$@"
