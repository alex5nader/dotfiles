{
  imports = [
    ./gnome
    ./ime
    ./keybinds
    ./programs
    ./wallpaper

    ./file-manager.nix
    ./gradle.nix
    ./metadata.nix
    ./shell.nix
    ./tray-target.nix
  ];

  _module.args.currentDevice = import ./current-device.nix; # This should be a file that evaluates to a string "desktop" or "laptop"
}
