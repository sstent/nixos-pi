/**
  nix build .#rpi
 */
{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, nixos-generators, ... }: {
    packages.aarch64-linux = {
      rpi = nixos-generators.nixosGenerate {
        system = "aarch64-linux";
        modules = [
          # you can include your own nixos configuration here, i.e.
          # ./configuration.nix
          {
            config = {
              boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
              nixpkgs.hostPlatform = "x86_64-linux";
              networking.hostName = "odroid";
              system = {
                stateVersion = "22.11";

                # Disable zstd compression
                # build.sdImage.compressImage = false;
              };
              users.users.root = {
                openssh.authorizedKeys.keys = [
                  "ssh-rsa ... "
                ];
              };
            };
          }
        ];
        format = "sd-aarch64";
      };
      # vbox = nixos-generators.nixosGenerate {
      #   system = "aarch64-linux";
      #   format = "virtualbox";
      # };
    };
  };
}