{ pkgs, ... }:

{
  home.packages = import ./extensions.nix pkgs;
}