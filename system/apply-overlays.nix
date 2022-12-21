{ my-pkgs, ... }:

{
  nixpkgs.overlays = my-pkgs.overlays;
}