{
  description = "My device configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    mozilla = {
      url = "github:mozilla/nixpkgs-mozilla";
    };

    firefox = {
      url = "github:nix-community/flake-firefox-nightly";
    };

    # TODO: add stylix?
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, mozilla, firefox }:
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

      # To run these shells, use `nix develop sys#name`.
      devShells.${system} = {
        # whoever wrote this post i love you it just works:tm: https://www.reddit.com/r/Coq/comments/1d33a15/coq_nixos_setup/
        buildCoq = pkgs.mkShell {
          nativeBuildInputs = with pkgs; [ ocaml opam pkg-config gcc bintools-unwrapped gmp ];
        };
        bevy = pkgs.mkShell rec {
          nativeBuildInputs = with pkgs; [ pkg-config ];
          buildInputs = with pkgs; [ udev alsa-lib vulkan-loader xorg.libX11 xorg.libXcursor xorg.libXi xorg.libXrandr libxkbcommon wayland ];
          LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath buildInputs;
        };
      };
    };
}
