{ pkgs, ... }:

{
  fonts = {
    packages = with pkgs; [
      inter
      nerd-fonts.fira-code
      ipafont # cjk
      twemoji-color-font
      tt2020
    ];

    fontconfig.defaultFonts = {
      sansSerif = [ "Inter" ];
      monospace = [ "FiraCode Nerd Font" ];
      emoji = [ "Twitter Color Emoji" ];
    };
  };
}
