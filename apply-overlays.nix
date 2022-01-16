{ config, options, ... }:

{
  nixpkgs.overlays = import ./overlays config.programs.javaPackages;

  nix.nixPath = options.nix.nixPath.default ++ [
    "nixpkgs-overlays=/etc/nixos/overlays/compat/"
  ];
}