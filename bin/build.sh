#!/bin/sh

# shellcheck disable=SC2046
docker stop $(docker ps -a -q --format '{{.Names}}' | grep_adventure)
# shellcheck disable=SC2046
docker rm $(docker ps -a -q --format '{{.Names}}' | grep_adventure)

docker-compose up --build "$@"
