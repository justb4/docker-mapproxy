#!/bin/bash

# Run as this/your local user
export HOST_UID_GID="$(id -u):$(id -g)"

mkdir -p cache
mkdir -p log
docker-compose rm --force --stop
docker-compose up -d
