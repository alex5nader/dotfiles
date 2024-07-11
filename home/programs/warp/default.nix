{ pkgs, ... }:

{
  home.packages = with pkgs; [
    warp-terminal
  ];

  xdg.dataFile = {
    "warp-terminal/themes/nord.yaml".source = ./nord.yaml;
    "warp-terminal/launch_configurations/rust.yaml".source = ./launch_configs/rust.yaml;
  };

  # Disable git pager when in warp
  programs.fish.interactiveShellInit = ''
    set -l parent (basename (readlink "/proc/$(cat /proc/$(echo $fish_pid)/stat|cut -d ' ' -f 4)/exe"))

    if test "$parent" = warp
      set -g -x GIT_PAGER
    end
  '';
}

