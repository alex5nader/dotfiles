{ pkgs, ... }:

{
  stylix.iconTheme = {
    enable = true;
    dark = "Papirus";
    light = "Papirus";
    package = pkgs.papirus-nord;
  };
}
