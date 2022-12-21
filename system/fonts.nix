{ pkgs, ... }:

{
  fonts = {
    enableDefaultFonts = false; # TODO: go back to default fonts, twemoji don't work anyway
    fonts = with pkgs; [
      # sans & serif
      ttf_bitstream_vera liberation_ttf
      # monospace
      fira-code
      (nerdfonts.override { fonts = [ "FiraCode" ]; })
      # cjk
      ipafont
      # emoji
      twemoji-color-font
    ];
    fontconfig = {
      defaultFonts = {
        emoji = [
          "Twitter Color Emoji"
          "IPAGothic"
        ];
        monospace = [
          "Fira Code"
          "IPAGothic"
        ];
        sansSerif = [
          "Bitstream Vera Sans"
          "IPAGothic"
        ];
        serif = [
          "Bitstream Vera Serif"
          "IPAGothic"
        ];
      };
    };
  };
}