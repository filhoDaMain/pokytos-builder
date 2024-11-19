#!/bin/bash

# 'sed_marker' will be substituted by install.sh script with
# path to pokytos-builder Makefile
pushd sed_marker

# Source env vars
. ENV_FILE

# Start container
make run

popd
