{ config, options, ... }:

{
  nixpkgs.overlays = import ./overlays;

  nix.nixPath = options.nix.nixPath.default ++ [
    "nixpkgs-overlays=/etc/nixos/overlays/compat/"
  ];
}