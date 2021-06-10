{ pkgs, lib, ... }:

let
  inherit (lib) recursiveUpdate;
  inherit (lib.lists) map foldr;

  files = [
    ./keybinds.nix
    ./mozc.nix
    ./workspaces.nix
  ];
  settings = map (x: import x { inherit pkgs lib; }) files;
in
{
  dconf.settings = foldr recursiveUpdate {} settings;
}
