#!/bin/bash

set -euo pipefail

IMAGE_NAME="pokytos-builder"

docker build \
    --build-arg UNAME="$(id -un)" \
    --build-arg UID="$(id -u)" \
    --build-arg GID="$(id -g)" \
    -t "$IMAGE_NAME" \
    -f Dockerfile \
    .
