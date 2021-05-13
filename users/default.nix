{ pkgs, ...}:

{
  imports = [
    <home-manager/nixos>
    ./noobstar
  ];

  home-manager.useGlobalPkgs = true;
}