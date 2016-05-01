#!/bin/bash

DOWNLOAD_URL="http://archive.ubuntu.com/ubuntu/dists/xenial/main/installer-amd64/current/images/netboot/netboot.tar.gz"

download() {
    if [ -x "$(command -v wget)" ]; then
        wget -P pxe "$DOWNLOAD_URL"
    else
        echo "wget not available, please install or download using another method"
    fi
}

unpack() {
  tar xf pxe/netboot.tar.gz -C pxe
}

[ -f pxe/netboot.tar.gz ] && echo "Already downloaded" || download
unpack
