{
  description = "My device configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    my-pkgs.url = "path:./my-pkgs";

    home-manager = {
      url = "github:nix-community/home-manager/release-22.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    budgie = {
      url = "github:FedericoSchonborn/budgie-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, my-pkgs, home-manager, budgie }:
    let
      system = "x86_64-linux";

      pkgs = import nixpkgs {
        inherit system;

        config.allowUnfree = true;
        overlays = my-pkgs.overlays ++ builtins.attrValues budgie.overlays ++ [
          (self: super: { unstable = nixpkgs-unstable.outputs.legacyPackages.${system}; })
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
              inherit pkgs budgie mkIfDevice;
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