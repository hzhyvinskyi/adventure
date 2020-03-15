#!/bin/sh

# shellcheck disable=SC2046
docker stop $(docker ps -a -q --format '{{.Names}}' | grep adventure_)
