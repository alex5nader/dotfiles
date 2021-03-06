{ pkgs, ... }:

{
  imports = [
    ./java.nix
  ];

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    git

    libimobiledevice

    pciutils glxinfo ripgrep gnome.gnome-tweaks file
  ];

  programs.gnupg.agent.enable = true; # TODO: missing pinentryFlavor = "gnome3" -- is this necessary?
  programs.steam.enable = true;

  programs.javaPackages = {
    jdk8 = pkgs.openjdk8;
    jdk11 = pkgs.openjdk11;
    jdk17 = pkgs.openjdk17;
  };
}
