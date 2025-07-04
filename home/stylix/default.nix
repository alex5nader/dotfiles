{ pkgs, ... }:

{
  stylix.iconTheme = {
    enable = true;
    dark = "Papirus";
    light = "Papirus";
    package = pkgs.papirus-nord;
  };

  stylix.targets.fcitx5.enable = false;  # causes arcane error: https://github.com/nix-community/home-manager/pull/6940
  stylix.targets.firefox.enable = false;
}
