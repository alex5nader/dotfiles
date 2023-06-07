{ pkgs, ... }:

{
  users.users.noobstar = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.fish;
  };

  programs.fish.enable = true;
}

