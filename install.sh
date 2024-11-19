#!/bin/bash

# Installation path
INSTALLATION_PATH=/usr/local/bin/pokytos-builder.sh

# Path to pokytos-builder Makefile (current dir)
POKYTOS_BUILDER_MAKEPATH=$(pwd)

cp ${POKYTOS_BUILDER_MAKEPATH}/pokytos-builder.sh ${INSTALLATION_PATH}
sed -i "s#sed_marker#${POKYTOS_BUILDER_MAKEPATH}#g" ${INSTALLATION_PATH}
