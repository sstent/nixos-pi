# NixOS Pi

[![Build OS Image](https://github.com/davegallant/nixos-pi/actions/workflows/build-sd-image.yaml/badge.svg)](https://github.com/davegallant/nixos-pi/actions/workflows/build-sd-image.yaml)

This repo contains configuration for creating an NixOS image that runs on a Raspberry Pi.

## Installation

### Github Actions

The workflow runs on Ubuntu and emulates the ARM platform with QEMU.

When the build finishes, there will be an artifact named `sd-image.img.zip`.

### Extract

This archive can be decompressed and the image can flashed on an SD card and used to boot up the OS:

```bash
unzip sd-image.img.zip
unzstd nixos-sd-image-21.05pre-git-aarch64-linux.img.zst
```

### Flash to SD

The image can be flashed using the [Raspberry Pi Imager](https://www.raspberrypi.org/blog/raspberry-pi-imager-imaging-utility/) or a simpler tool such as [dd](https://man7.org/linux/man-pages/man1/dd.1.html).

## Addtional Resources

- [NixOS on ARM](https://nixos.wiki/wiki/NixOS_on_ARM#Installation)
