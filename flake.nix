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
      unstable = nixpkgs-unstable.outputs.legacyPackages.${system};
      unstable-overlay = { ... }: { nixpkgs.overlays = [ (self: super: { inherit unstable; }) ]; };
    in
    {
      nixosConfigurations = {
        noobstar-laptop = nixpkgs.lib.nixosSystem {
          inherit system;

          modules = [ unstable-overlay ./system ];
          specialArgs = {
            inherit my-pkgs;
            currentDevice = "laptop";
          };
        };
      };

      jdks = self.nixosConfigurations.noobstar-laptop.config.programs.javaPackages;

      # homeConfigurations = {
      #   "noobstar@noobstar-laptop" = home-manager.lib.homeManagerConfiguration {
      #     pkgs = nixpkgs.legacyPackages.${system};

      #     modules = import ./home;
      #     extraSpecialArgs = {
      #       currentDevice = "laptop";
      #     };
      #   };
      # };
    };
}