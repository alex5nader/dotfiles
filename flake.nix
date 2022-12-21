{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";
  };

  outputs = { self, nixpkgs }: {
    nixosConfigurations = {
      noobstar-laptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = import ./system;
        specialArgs = { currentDevice = "laptop"; };
      };
    };
  };
}