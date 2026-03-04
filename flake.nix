{
  description = "My device configuration";

  inputs = {
    firefox = {
      url = "github:nix-community/flake-firefox-nightly";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lix = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.93.3-2.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    mozilla = {
      url = "github:mozilla/nixpkgs-mozilla";
    };

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs-stable.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    stylix = {
      url = "github:nix-community/stylix/release-25.11";
      # TODO: does this break anything? docs didn't specify it
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { firefox
    , home-manager
    , lix
    , mozilla
    , niri
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
          niri.overlays.niri
        ];
      };

      configuration = currentDevice: extraNixosModules:
        let
          inherit (nixpkgs.lib) mkIf mkMerge;
          inherit (nixpkgs.lib.attrsets) foldlAttrs;
          mkIfDevice = device: value: mkIf (device == currentDevice) value;
          mkWhenDevice = cases: mkMerge (foldlAttrs (acc: device: value: [(mkIfDevice device value)] ++ acc) [] cases);
        in
        rec {
          nixos = nixpkgs.lib.nixosSystem {
            system = null;

            modules = extraNixosModules ++ [
              { nixpkgs.pkgs = pkgs; }
              nixpkgs.nixosModules.readOnlyPkgs
              niri.nixosModules.niri
              stylix.nixosModules.stylix
              ./system
              home-manager.nixosModules.home-manager
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.users.noobstar = ./home;
                home-manager.extraSpecialArgs = {
                  inherit mkIfDevice mkWhenDevice;
                  my-jdks = nixos.config.programs.javaPackages;
                };
              }
            ];
            specialArgs = {
              inherit mkIfDevice mkWhenDevice;
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
