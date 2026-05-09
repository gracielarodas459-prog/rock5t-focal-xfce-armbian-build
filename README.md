# ROCK 5T Ubuntu Jammy XFCE Armbian Builder

Private GitHub Actions builder for Radxa ROCK 5T images.

## Decision

The original `ubuntu_focal_desktop/server_xfce_linux6.1.43` target did not produce a usable ROCK 5T image in the current Armbian build stack because current Armbian package metadata no longer includes Ubuntu Focal `base-files` entries.

This repo now defaults to a newer usable Ubuntu route:

- `BOARD=rock-5t`
- `BRANCH=vendor`
- `RELEASE=jammy`
- `BUILD_DESKTOP=yes`
- `DESKTOP_ENVIRONMENT=xfce`
- `DESKTOP_TIER=mid`

## Why this route

Radxa's HDMI RX documentation expects the HDMI RX input to appear as a V4L2 video capture device, normally `/dev/video0`, driven by `rk_hdmirx` / Rockchip HDMI RX support. The current fnOS kernel on the target has the device tree node enabled but lacks the needed V4L2 platform / HDMI RX kernel options, so just replacing userland is not enough.

Armbian `rock-5t` vendor builds are board-specific and include the RK3588 vendor kernel config with:

- `CONFIG_V4L_PLATFORM_DRIVERS=y`
- `CONFIG_VIDEO_ROCKCHIP_HDMIRX=y`

That matches the HDMI RX requirement better than the current fnOS kernel.

## Safety notes

- Use only ROCK 5T board assets: `rock-5t`, `rk3588-rock-5t.dtb`.
- Do not flash Orange Pi 5 Plus / ROCK 5B images to ROCK 5T just because they are RK3588 or mention Linux 6.1.
- The vendor branch currently tracks a newer Rockchip 6.1 vendor kernel family, not the exact `6.1.43` string.

## Build output

The produced `.img` / `.img.xz` files are uploaded as GitHub Actions workflow artifacts named like:

`rock5t-jammy-xfce-armbian-vendor`
