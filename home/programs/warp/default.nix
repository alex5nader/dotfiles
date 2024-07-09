{ pkgs, ... }:

{
  home.packages = with pkgs; [
    warp-terminal
  ];

  xdg.dataFile."warp-terminal/themes/nord.yaml".source = ./nord.yaml;
}

