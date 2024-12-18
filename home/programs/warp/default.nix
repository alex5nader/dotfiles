{ pkgs, ... }:

{
  home.packages = with pkgs; [
    warp-terminal
  ];

  xdg.dataFile = {
    "warp-terminal/themes/nord.yaml".source = ./nord.yaml;
    "warp-terminal/launch_configurations/rust.yaml".source = ./launch_configs/rust.yaml;
  };

  programs.fish.functions = {
    shell_parent = ''
      set -l my_name (pid_name $fish_pid)
      set -l parent (parent_pid $fish_pid)

      while test "$(pid_name $parent)" = "$my_name"
        set parent (parent_pid $parent)
      end

      pid_name "$parent"
    '';

    warpify = ''
      if test "$(shell_parent)" = warp
        # Disable git pager
        set -g -x GIT_PAGER

        printf '\eP$f{"hook": "SourcedRcFileForWarp", "value": { "shell": "fish" }}\x9c'
      end
    '';
  };

  programs.fish.interactiveShellInit = "warpify";
}

