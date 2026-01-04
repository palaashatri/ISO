#!/bin/sh
set -e

echo ">>> Building Broadcom firmware ports inside chroot..."

# Ensure ports tree exists
if [ ! -d /usr/ports ]; then
    portsnap fetch extract
else
    portsnap fetch update
fi

# Build bwi firmware if present
if [ -d /usr/ports/net/bwi-firmware-kmod ]; then
    cd /usr/ports/net/bwi-firmware-kmod
    make -DBATCH install clean
else
    echo ">>> WARNING: bwi-firmware-kmod port missing"
fi

# Build bwn firmware if present
if [ -d /usr/ports/net/bwn-firmware-kmod ]; then
    cd /usr/ports/net/bwn-firmware-kmod
    make -DBATCH install clean
else
    echo ">>> WARNING: bwn-firmware-kmod port missing"
fi

echo ">>> Broadcom firmware build step complete."
