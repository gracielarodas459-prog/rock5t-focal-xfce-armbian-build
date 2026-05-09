#!/usr/bin/env bash
set -euo pipefail

BOARD="${BOARD:-rock-5t}"
BRANCH="${BRANCH:-vendor}"
RELEASE="${RELEASE:-focal}"
BUILD_DESKTOP="${BUILD_DESKTOP:-yes}"
DESKTOP_ENVIRONMENT="${DESKTOP_ENVIRONMENT:-xfce}"
DESKTOP_TIER="${DESKTOP_TIER:-mid}"
DESKTOP_ENVIRONMENT_CONFIG_NAME="${DESKTOP_ENVIRONMENT_CONFIG_NAME:-config_base}"
KERNEL_CONFIGURE="${KERNEL_CONFIGURE:-no}"
BUILD_MINIMAL="${BUILD_MINIMAL:-no}"

if [[ "$BOARD" != "rock-5t" ]]; then
  echo "Refusing to build non-ROCK-5T board: $BOARD" >&2
  exit 2
fi

if [[ ! -d armbian-build ]]; then
  git clone --depth 1 https://github.com/armbian/build.git armbian-build
fi
cd armbian-build

echo "== ROCK 5T board config =="
sed -n '1,80p' config/boards/rock-5t.conf

echo "== RK3588 family kernel source config =="
sed -n '17,45p' config/sources/families/rockchip-rk3588.conf

echo "== Build parameters =="
printf 'BOARD=%s\nBRANCH=%s\nRELEASE=%s\nBUILD_DESKTOP=%s\nDESKTOP_ENVIRONMENT=%s\nDESKTOP_TIER=%s\nDESKTOP_ENVIRONMENT_CONFIG_NAME=%s\nBUILD_MINIMAL=%s\nKERNEL_CONFIGURE=%s\n' \
  "$BOARD" "$BRANCH" "$RELEASE" "$BUILD_DESKTOP" "$DESKTOP_ENVIRONMENT" "$DESKTOP_TIER" "$DESKTOP_ENVIRONMENT_CONFIG_NAME" "$BUILD_MINIMAL" "$KERNEL_CONFIGURE"

sudo ./compile.sh \
  BOARD="$BOARD" \
  BRANCH="$BRANCH" \
  RELEASE="$RELEASE" \
  BUILD_DESKTOP="$BUILD_DESKTOP" \
  DESKTOP_ENVIRONMENT="$DESKTOP_ENVIRONMENT" \
  DESKTOP_TIER="$DESKTOP_TIER" \
  DESKTOP_ENVIRONMENT_CONFIG_NAME="$DESKTOP_ENVIRONMENT_CONFIG_NAME" \
  BUILD_MINIMAL="$BUILD_MINIMAL" \
  KERNEL_CONFIGURE="$KERNEL_CONFIGURE" \
  COMPRESS_OUTPUTIMAGE=sha,gpg,img,xz

mkdir -p ../artifacts
find output/images -maxdepth 1 -type f \( -name '*.img' -o -name '*.img.xz' -o -name '*.sha' -o -name '*.sha256' -o -name '*.txt' \) -print -exec cp -v {} ../artifacts/ \;
