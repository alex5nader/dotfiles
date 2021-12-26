{
  imports = [
    ./device-support.nix

    ./apply-overlays.nix
    ./boot.nix
    ./device-support.nix
    ./displays.nix
    ./drives.nix
    ./fonts.nix
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

  current-device = "laptop";
}