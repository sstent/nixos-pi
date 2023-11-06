/**
  nix build .#odroid
  nix build --option system aarch64-linux --option sandbox false .#odroid
 */
{
  inputs = {
    #nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.05";
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, nixos-generators, ... }: {
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
    };
    lib = nixpkgs.lib;

nixosConfigurations.rpi2 = lib.nixosSystem {
      system = "armv7l-linux";

      modules = [
          ({ pkgs, config, ... }: {

            imports = [
                      # https://nixos.wiki/wiki/NixOS_on_ARM#Build_your_own_image
                      # "${nixpkgs}/nixos/modules/installer/sd-card/sd-image-armv7l-multiplatform-installer.nix"
                      "${nixpkgs}/nixos/modules/installer/sd-card/sd-image-armv7l-multiplatform.nix"
                      cacheConfig
                      ];
            services.openssh = {
              enable = true;
              permitRootLogin = "yes";
            };
            boot.kernelPackages = lib.mkForce config.boot.zfs.package.latestCompatibleLinuxPackages;
            users.extraUsers.root.initialPassword = lib.mkForce "test123";
        })
      ];
    };


    packages.armv7l-linux = {
      odroid7 = nixos-generators.nixosGenerate {
        system = "armv7l-linux";
        modules = [
          {
            config = {
              boot.binfmt.emulatedSystems = [ "armv7l-linux" ];

              networking.hostName = "odroid7";
              system = {
                stateVersion = "22.11";

                # Disable zstd compression
                #build.sdImage.compressImage = false;
              };
              # users.users.root = {
              #   openssh.authorizedKeys.keys = [
              #     "ssh-rsa ... "
              #   ];

              # };
            };
          }
        ];
        format = "sd-aarch64-installer";
      };
    };
    
    
    packages.aarch64-linux = {
      odroid = nixos-generators.nixosGenerate {
        system = "aarch64-linux";
        modules = [
          {
            config = {
              boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

              networking.hostName = "odroid";
              system = {
                stateVersion = "22.11";

                # Disable zstd compression
                #build.sdImage.compressImage = false;
              };
              # users.users.root = {
              #   openssh.authorizedKeys.keys = [
              #     "ssh-rsa ... "
              #   ];
              # };
            };
          }
        ];
        format = "sd-aarch64";
      };
    };
  };
}
