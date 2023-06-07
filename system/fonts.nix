{ pkgs, ... }:

{
  fonts = {
    fonts = with pkgs; [
      inter
      (nerdfonts.override { fonts = [ "FiraCode" ]; })
      ipafont # cjk
      twemoji-color-font
    ];

    fontconfig.defaultFonts = {
      sansSerif = [ "Inter" ];
      monospace = [ "FiraCode Nerd Font Ret" ];
      emoji = [ "Twitter Color Emoji" ];
    };
  };
}