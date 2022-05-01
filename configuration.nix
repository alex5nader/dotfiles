{
  imports = [
    ./options
    ./programs

    ./apply-overlays.nix
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
    ./printing.nix
    ./sound.nix
    ./users.nix
    ./virtualisation.nix
    ./vpn.nix
  ];

  _module.args.currentDevice = import ./current-device.nix; # This should be a file that evaluates to a string "desktop" or "laptop"
}
