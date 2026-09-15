#!/bin/bash

# Installation paths
LAUNCHER_INSTALLATION_PATH=/usr/local/bin/pokytos-builder.sh
MOUNT_CONF_INSTALLATION_PATH=/usr/local/etc/pokytos-builder-MOUNT.conf
RUN_OPTS_INSTALLATION_PATH=/usr/local/etc/pokytos-builder-RUN_OPTS.conf

install -D -o root -g root -m 755 pokytos-builder.sh ${LAUNCHER_INSTALLATION_PATH}
install -D -o root -g root -m 644 MOUNT ${MOUNT_CONF_INSTALLATION_PATH}
install -D -o root -g root -m 644 RUN_OPTS ${RUN_OPTS_INSTALLATION_PATH}
