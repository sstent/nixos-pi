{ nixpkgs ? <nixpkgs> }:
let
  pkgs = import nixpkgs {
    system = "armv7l-linux";
  };
#   cacheConfig = {
#     nix.settings = {
#       substituters = [
#         "https://cache.armv7l.xyz"
#       ];
#       trusted-public-keys = [
#         "cache.armv7l.xyz-1:kBY/eGnBAYiqYfg0fy0inWhshUo+pGFM3Pj7kIkmlBk="
#       ];
#     };
#   };
in
{
#   isoMinimal = (pkgs.nixos ({ config, lib, pkgs, modulesPath, ... }: {
#     imports = [
#       (modulesPath + "/installer/cd-dvd/installation-cd-minimal.nix")
#     #   cacheConfig
#     ];
#     boot.kernelPackages = lib.mkForce config.boot.zfs.package.latestCompatibleLinuxPackages;
#   })).config.system.build.isoImage;

  sdImage = (pkgs.nixos ({ config, lib, pkgs, modulesPath, ... }: { 
    imports = [
      (modulesPath + "/installer/sd-card/sd-image-armv7l-multiplatform-installer.nix")
    #   cacheConfig
    ];
    boot.kernelPackages = lib.mkForce config.boot.zfs.package.latestCompatibleLinuxPackages;
  })).config.system.build.sdImage;
}
