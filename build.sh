#!/bin/bash

set -euo pipefail

IMAGE_NAME="pokytos-builder"

docker build \
    -t "$IMAGE_NAME" \
    -f Dockerfile \
    .
