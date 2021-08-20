{ pkgs, ...}:

{
  imports = [
    <home-manager/nixos>
    ./noobstar
  ];

  home-manager.useGlobalPkgs = true;

  services.xserver.desktopManager.wallpaper.mode = "max";
}