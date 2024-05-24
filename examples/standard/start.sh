#!/bin/bash

mkdir -p cache
mkdir -p log
docker-compose rm --force --stop
docker-compose up -d
