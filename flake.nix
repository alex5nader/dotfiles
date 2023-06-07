{
  description = "My device configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    mozilla = {
      url = "github:mozilla/nixpkgs-mozilla";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, mozilla }:
    let
      system = "x86_64-linux";

      pkgs = import nixpkgs {
        inherit system;

        config.allowUnfree = true;
        overlays = [
          mozilla.overlay
          (import ./my-pkgs/overlay.nix)
          (import ./overlay.nix { inherit nixpkgs-unstable; })
        ];
      };

      configuration = currentDevice:
        let
          inherit (nixpkgs.lib) mkIf;
          mkIfDevice = device: value: mkIf (device == currentDevice) value;
        in
        rec {
          nixos = nixpkgs.lib.nixosSystem {
            system = null;

            modules = [ ./system ];
            specialArgs = {
              inherit pkgs mkIfDevice;
            };
          };

          home = home-manager.lib.homeManagerConfiguration {
            inherit pkgs;

            modules = [ ./home ];
            extraSpecialArgs = {
              inherit mkIfDevice;
              my-jdks = nixos.config.programs.javaPackages;
            };
          };
        };

      laptop = configuration "laptop";
      desktop = configuration "desktop";
    in
    {
      nixosConfigurations = {
        noobstar-laptop = laptop.nixos;
        noobstar-pc = desktop.nixos;
      };

      homeConfigurations = {
        "noobstar@noobstar-laptop" = laptop.home;
        "noobstar@noobstar-pc" = desktop.home;
      };
    };
}
