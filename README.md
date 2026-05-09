# ROCK 5T Ubuntu Focal XFCE Armbian Builder

Private GitHub Actions builder for Radxa ROCK 5T images.

## Important finding

The requested string `ubuntu_focal_desktop/server_xfce_linux6.1.43` was not found as a public ROCK 5T build target or release asset.

Verified safe ROCK 5T source:

- `armbian/build` has `config/boards/rock-5t.conf`
- board: `rock-5t`
- DTB: `rockchip/rk3588-rock-5t.dtb`
- supported branches: `vendor,current`
- Ubuntu Focal exists in Armbian distributions
- XFCE desktop is selected with `BUILD_DESKTOP=yes DESKTOP_ENVIRONMENT=xfce`

Kernel note:

- Armbian `rockchip-rk3588` vendor branch currently tracks Linux `6.1.115`, not `6.1.43`.
- Orange Pi `linux6.1.43` evidence was only found in Orange Pi/CM5-tablet-style configs, not ROCK 5T. Do not flash Orange Pi 5 Plus images to ROCK 5T.

## Build

Manual Actions dispatch defaults to a safe ROCK 5T image:

- `BOARD=rock-5t`
- `BRANCH=vendor`
- `RELEASE=focal`
- `BUILD_DESKTOP=yes`
- `DESKTOP_ENVIRONMENT=xfce`

The produced `.img`/`.img.xz` files are uploaded as workflow artifacts.
