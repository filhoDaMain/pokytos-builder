#!/bin/bash

# Installation paths
LAUNCHER_INSTALLATION_PATH=/usr/local/bin/pokytos-builder.sh
CONF_INSTALLATION_PATH=/usr/local/etc/pokytos-builder.conf

install -D -o root -g root -m 755 pokytos-builder.sh ${LAUNCHER_INSTALLATION_PATH}
install -D -o root -g root -m 644 MOUNT ${CONF_INSTALLATION_PATH}
