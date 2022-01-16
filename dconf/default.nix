{ pkgs, lib, ... }:

let
  inherit (lib) recursiveUpdate;
  inherit (lib.lists) map foldr;

  files = [
    ./gnome

    ./keybinds.nix
    ./mozc.nix
    ./wallpaper.nix
  ];
  settings = map (x: import x { inherit pkgs lib; }) files;
in
{
  dconf.settings = foldr recursiveUpdate {} settings;
}
