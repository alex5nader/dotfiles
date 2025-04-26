{ pkgs, ... }:
{
  # TODO: keep track of this issue, dynamic theme would be nice
  # https://github.com/danth/stylix/issues/447
  stylix.enable = true;
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml";
  stylix.image = ./wallpaper.png;

  stylix.fonts = {
    sansSerif = {
      package = pkgs.inter;
      name = "Inter";
    };
    monospace = {
      package = (pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; });
      name = "FiraCode Nerd Font";
    };
    emoji = {
      package = pkgs.twemoji-color-font;
      name = "Twitter Color Emoji";
    };

    sizes = {
      terminal = 16;
    };
  };

  fonts.packages = with pkgs; [
    ipafont
    tt2020
  ];

  stylix.cursor = {
    package = pkgs.nordic;
    name = "Nordic-cursors";
    size = 64;
  };

  # needs to be enabled in dconf via home manager
  # org/gnome/desktop/interface icon-theme
  environment.systemPackages = with pkgs; [
    papirus-icon-theme
  ];
}
