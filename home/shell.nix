{ config, pkgs, ... }:

let
  makeNavigationFunction = { type, prefix }: {
    description = "Navigate to a ${type} folder.";
    argumentNames = [ "folder" ];
    wraps = "cd";
    body = ''
      if test -n "$folder"
        cd ${prefix}/$folder
      else
        cd ${prefix}
      end
    '';
  };
in

{
  home.packages = with pkgs; [ any-nix-shell ];

  home.sessionVariables = {
    VIRSH_DEFAULT_CONNECT_URI = "qemu:///system";
    LESS = "-R --mouse --wheel-lines=3";
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      any-nix-shell fish --info-right | source
    '';

    functions = {
      fish_greeting = "";

      config = {
        description = "Edit configuration files.";
        body = ''
          exec zellij -l config
        '';
      };

      pid_name = ''
        basename (readlink -f /proc/$argv[1]/exe)
      '';

      parent_pid = ''
        cat /proc/$argv[1]/stat | cut -d' ' -f4
      '';

      sch = makeNavigationFunction {
        type = "school";
        prefix = "${config.home.homeDirectory}/School";
      };
      proj = makeNavigationFunction {
        type = "project";
        prefix = "${config.home.homeDirectory}/Projects";
      };
      docs = makeNavigationFunction {
        type = "folder";
        prefix = "${config.home.homeDirectory}/Documents";
      };
      osc = makeNavigationFunction {
        type = "folder";
        prefix = "${config.home.homeDirectory}/Projects/osc";
      };

      set-perf = {
        description = "Set CPU scaling_governor";
        argumentNames = [ "scaling_governor" ];
        body = ''
          set available (cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_governors | string split " ")

          if test -z "$scaling_governor"
            echo >&2 "Usage: set-perf <scaling_governor>"
            echo >&2 "Use one of the following: $available"
            return 1
          end

          if ! contains "$scaling_governor" $available
            echo >&2 "Invalid scaling governor. Expected one of: $available"
            return 1
          end

          echo "$scaling_governor" | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
        '';
      };
    };
  };

  programs.starship.enable = true; # TODO: why don't I need enableFishIntegration? does any-nix-shell cover it somehow?
}
