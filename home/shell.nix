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

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      any-nix-shell fish --info-right | source
      source /home/noobstar/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true
    '';

    functions = {
      fish_greeting = "";

      config = {
        description = "Edit configuration files.";
        argumentNames = [ "type" ];
        body = ''
          switch $type
            case system
              ${config.programs.vscode.package}/bin/code ${config.home.homeDirectory}/Projects/system-config
            case home
              ${config.programs.vscode.package}/bin/code ${config.home.homeDirectory}/Projects/home-config
            case '*'
              echo "Must enter either 'system' or 'home'."
          end
        '';
      };

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
    };
  };

  programs.starship.enable = true; # TODO: why don't I need enableFishIntegration? does any-nix-shell cover it somehow?
}
