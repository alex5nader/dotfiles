{
  imports = [
    ./programs

    ./apply-overlays.nix
    ./boot.nix
    ./displays.nix
    ./drives.nix
    ./fonts.nix
    ./gnome.nix
    ./ime.nix
    ./internet.nix
    ./kernel.nix
    ./localization.nix
    ./metadata.nix
    ./misc-hardware.nix
    ./sound.nix
    ./users.nix
    ./vpn.nix
  ];

  _module.args.currentDevice = "laptop";
}
