{
  description = "My device configuration";

  inputs = {
    firefox = {
      url = "github:nix-community/flake-firefox-nightly";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lix = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.92.0-3.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    mozilla = {
      url = "github:mozilla/nixpkgs-mozilla";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    stylix = {
      url = "github:danth/stylix/release-24.11";
      # TODO: does this break anything? docs didn't specify it
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { firefox
    , home-manager
    , lix
    , mozilla
    , nixos-hardware
    , nixpkgs
    , nixpkgs-unstable
    , self
    , stylix
    }:
    let
      system = "x86_64-linux";

      pkgs = import nixpkgs {
        inherit system;

        config.allowUnfree = true;
        overlays = [
          mozilla.overlay
          (self: super: {
            firefox-nightly-bin = firefox.packages.${system}.firefox-nightly-bin;
          })
          (import ./my-pkgs/overlay.nix)
          (import ./overlay.nix { inherit nixpkgs-unstable; })
          lix.overlays.default
        ];
      };

      configuration = currentDevice: extraNixosModules:
        let
          inherit (nixpkgs.lib) mkIf;
          mkIfDevice = device: value: mkIf (device == currentDevice) value;
        in
        rec {
          nixos = nixpkgs.lib.nixosSystem {
            system = null;

            modules = extraNixosModules ++ [
              stylix.nixosModules.stylix
              ./system
              home-manager.nixosModules.home-manager
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.users.noobstar = ./home;
                home-manager.extraSpecialArgs = {
                  inherit mkIfDevice;
                  my-jdks = nixos.config.programs.javaPackages;
                };
              }
            ];
            specialArgs = {
              inherit pkgs mkIfDevice;
            };
          };
        };

      laptop = configuration "laptop" [ nixos-hardware.nixosModules.framework-11th-gen-intel ];
      desktop = configuration "desktop" [ ];
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

      # To run these shells, use `nix develop sys#name`.
      devShells.${system} = {
        # whoever wrote this post i love you it just works:tm: https://www.reddit.com/r/Coq/comments/1d33a15/coq_nixos_setup/
        buildCoq = pkgs.mkShell {
          nativeBuildInputs = with pkgs; [ ocaml opam pkg-config gcc bintools-unwrapped gmp ];
        };
        bevy = pkgs.mkShell rec {
          nativeBuildInputs = with pkgs; [ pkg-config ];
          buildInputs = with pkgs; [ clang mold udev alsa-lib vulkan-loader xorg.libX11 xorg.libXcursor xorg.libXi xorg.libXrandr libxkbcommon wayland ];
          LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath buildInputs;
        };
      };
    };
}
