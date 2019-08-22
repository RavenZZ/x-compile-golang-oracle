#!/usr/bin/env bash

cd `dirname $0`

echo "example:"
echo "docker build  --build-arg VERSION=1.12.9 --build-arg SHA256=ac2a6efcc1f5ec8bdc0db0a988bb1d301d64b6d61b7e8d9e42f662fbb75a2b9b --rm -t ravenzz/x-compile:1.12.9 ."

version=$1
sha256=$2

docker build  --build-arg VERSION=$version --build-arg SHA256=$sha256 --rm -t ravenzz/x-compile:${version} .
