{ lib, ... }:

let
  inherit (lib.strings) concatMapStringsSep;

  nord0 = "#2E3440";
  nord1 = "#3B4252";
  nord3 = "#4C566A";
  nord4 = "#D8DEE9";
  nord5 = "#E5E9F0";
  nord6 = "#ECEFF4";
  nord7 = "#8FBCBB";
  nord8 = "#88C0D0";
  nord9 = "#81A1C1";
  nord11 = "#BF616A";
  nord13 = "#EBCB8B";
  nord14 = "#A3BE8C";
  nord15 = "#B48EAD";

  nord0_rgb = "rgb(46,52,64)";
  nord1_rgb = "rgb(59,66,82)";
  nord4_rgb = "rgb(216,222,233)";
  nord8_rgb = "rgb(136,192,208)";

in

{
  programs.gnome-terminal.profile.Nord = {
    colors = {
      # palette = "[${concatMapStringsSep ", " (color: "'${color}'") palette}]";
      palette = [ nord1 nord11 nord14 nord13 nord9 nord15 nord8 nord5 nord3 nord11 nord14 nord13 nord9 nord15 nord7 nord6 ];
      backgroundColor = nord0;
      foregroundColor = nord4;

      cursor = {
        foreground = nord1_rgb;
        background = nord4_rgb;
      };

      highlight = {
        foreground = nord0_rgb;
        background = nord8_rgb;
      };
    };
  };
}