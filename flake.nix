{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, nixos-generators, ... }: {

    # A single nixos config outputting multiple formats.
    # Alternatively put this in a configuration.nix.
    nixosModules.rpi = {config, ...}: {
      imports = [
        nixos-generators.nixosModules.all-formats
      ];

      nixpkgs.hostPlatform = "x86_64-linux";
      format = "sd-aarch64";


      # customize an existing format
      formatConfigs.sd-aarch64 = {config, ...}: {
        services.openssh.enable = true;
      };


    # the evaluated machine
    nixosConfigurations.rpi = nixpkgs.lib.nixosSystem {
      modules = [self.nixosModules.rpi];
    };
  };
};
}
