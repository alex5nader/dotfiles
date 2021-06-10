{ pkgs, lib, ... }:

let
  inherit (lib) recursiveUpdate;
  inherit (lib.lists) map foldr;

  files = [
    ./gnome.nix
    ./keybinds.nix
    ./mozc.nix
  ];
  settings = map (x: import x { inherit pkgs lib; }) files;
in
{
  dconf.settings = foldr recursiveUpdate {} settings;
}
