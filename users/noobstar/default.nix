{ pkgs, ... }:

let
  keybinds = import ./keybinds.nix pkgs;
in

{
  imports = [
    <home-manager/nixos>
  ];

  users.users.noobstar = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.fish;
  };

  home-manager.users.noobstar = { lib, pkgs, ...}: with lib; {
    # packages
    home.packages = with pkgs; with jetbrains; [
      # general use
      firefox discord flameshot obs-studio peek

      # terminal
      exa fd sd dust

      # programming
      idea-ultimate clion webstorm pycharm-professional

      # admin
      arandr gnome3.dconf-editor
    ];

    # terminal
    programs.fish = {
      enable = true;
      functions = import ./fish-functions.nix;
      shellAliases = {
        ls = "${pkgs.exa}/bin/exa";
      };
    };
    programs.starship = {
      enable = true;
      enableFishIntegration = true;
    };


    # dconf
    dconf.settings =
      let
        settings = [
          (import ./keybinds.nix { inherit pkgs lib; })
        ];
      in
      lists.foldr lib.recursiveUpdate {} settings;
  };
}
