{ pkgs, ... }:

{
  fonts = {
    packages = with pkgs; [
      inter
      (nerdfonts.override { fonts = [ "FiraCode" ]; })
      ipafont # cjk
      twemoji-color-font
      tt2020
    ];

    fontconfig.defaultFonts = {
      sansSerif = [ "Inter" ];
      monospace = [ "FiraCode Nerd Font Ret" ];
      emoji = [ "Twitter Color Emoji" ];
    };
  };
}
