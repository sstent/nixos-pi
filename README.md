# NixOS ARM

[![Build OS Image](https://github.com/davegallant/nixos-pi/actions/workflows/build-sd-image.yaml/badge.svg)](https://github.com/davegallant/nixos-pi/actions/workflows/build-sd-image.yaml)

Currently throws error on build for AARCH64

```
error: builder for '/nix/store/4yga1bvvzcp8wbg8rzzznwjwnramyjp6-ext4-fs.img.zst.drv' failed with exit code 1;
       last 4 log lines:
       > Preparing store paths for image...
       > Creating an EXT4 image of 2512367616 bytes (numInodes=66425, numDataBlocks=480521)
       > mke2fs 1.47.0 (5-Feb-2023)
       > semop(1): encountered an error: Function not implemented
       For full logs, run 'nix log /nix/store/4yga1bvvzcp8wbg8rzzznwjwnramyjp6-ext4-fs.img.zst.drv'.
error: 1 dependencies of derivation '/nix/store/k78ampxdvlyg1q2hh9jr828w60jv1mgz-nixos-sd-image-23.11.20231029.0cbe9f6-aarch64-linux.img.drv' failed to build
Error: Process completed with exit code 1.
```
