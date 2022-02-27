#!/bin/sh

S6_OVERLAY_VERSION=$1
DOCKER_ARCH=$2
DOCKER_VARIANT=$3
S6_ARCH=$DOCKER_ARCH

# Map docker arch to S6 arch
case $DOCKER_ARCH/$DOCKER_VARIANT in
  amd64/)
    S6_ARCH=x86_64
    ;;

  386/)
    S6_ARCH=i686
    ;;

  arm64/)
    S6_ARCH=aarch64
    ;;

  arm/v7)
    S6_ARCH=armhf
    ;;

  arm/v6)
    S6_ARCH=arm
    ;;
esac

echo "$S6_OVERLAY_VERSION - $S6_ARCH"

curl -L -O --output-dir /tmp https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-noarch-${S6_OVERLAY_VERSION}.tar.xz
curl -L -O --output-dir /tmp https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-${S6_ARCH}-${S6_OVERLAY_VERSION}.tar.xz

tar -C / -Jxpf /tmp/s6-overlay-noarch-${S6_OVERLAY_VERSION}.tar.xz
tar -C / -Jxpf /tmp/s6-overlay-${S6_ARCH}-${S6_OVERLAY_VERSION}.tar.xz
