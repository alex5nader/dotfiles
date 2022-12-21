{
  description = "My device configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-22.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    my-pkgs.url = "path:./my-pkgs";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, my-pkgs, home-manager }:
    let
      system = "x86_64-linux";

      pkgs = import nixpkgs {
        inherit system;

        config.allowUnfree = true;
        overlays = my-pkgs.overlays ++ [
          (self: super: { unstable = nixpkgs-unstable.outputs.legacyPackages.${system}; })
        ];
      };

      configuration = currentDevice: rec {
        nixos = nixpkgs.lib.nixosSystem {
          system = null;

          modules = [ ./system ];
          specialArgs = {
            inherit pkgs currentDevice;
          }; 
        };

        home = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          modules = [ ./home ];
          extraSpecialArgs = {
            inherit currentDevice;

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