{ budgie, ... }:

{
  imports = [
    budgie.nixosModules.default

    ./programs

    ./boot.nix
    ./displays.nix
    ./drives.nix
    ./fonts.nix
    ./gnome.nix
    ./internet.nix
    ./kernel.nix
    ./localization.nix
    ./metadata.nix
    ./misc-hardware.nix
    ./nix-direnv.nix
    ./nix-flakes.nix
    ./nixpkgs.nix
    ./printing.nix
    ./sound.nix
    ./users.nix
    ./virtualisation.nix
    ./vpn.nix
  ];
}

