{ pkgs, ... }:

{
  home.packages = with pkgs; [
    warp-terminal
  ];

  xdg.dataFile = {
    "warp-terminal/themes/nord.yaml".source = ./nord.yaml;
    "warp-terminal/launch_configurations/rust.yaml".source = ./launch_configs/rust.yaml;
  };
}

