{ pkgs, ... }:

{
  imports = [
    ./java.nix
  ];

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    git

    libimobiledevice

    pciutils glxinfo ripgrep gnome.gnome-tweak-tool file
  ];

  programs.gnupg.agent.enable = true;
  programs.steam.enable = true;

  programs.javaPackages = {
    jdk8 = pkgs.openjdk8;
    jdk11 = pkgs.openjdk11;
    jdk16 = pkgs.adoptopenjdk-hotspot-bin-16;
  };
}
