{ config, ... }:

let
  target = ".background-image";
  picture-uri = "file://${config.home.homeDirectory}/${target}";
in

{
  home.file = {
    wallpaper = {
      source = ./wallpaper.png;
      inherit target;
    };
  };

  dconf.settings = {
    "org/gnome/desktop/background" = { inherit picture-uri; };
    "org/gnome/desktop/screensaver" = { inherit picture-uri; };
  };
}