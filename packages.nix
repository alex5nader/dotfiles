{ config, pkgs, ... }:

let
  jdk8 = pkgs.openjdk8;
  jdk16 = pkgs.unstable.openjdk16;
in

{
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    # programming
    git vscode jdk8 jdk16

    # admin
    pciutils glxinfo ripgrep gnome3.gnome-tweak-tool
  ];

  programs.gnupg.agent = {
    enable = true;
    pinentryFlavor = "gnome3";
  };

  programs.steam.enable = true;

  services.dbus.packages = with pkgs; [ gnome3.dconf ];


  environment.etc = {
    "jdk8".source = jdk8;
    "jdk16".source = jdk16;
  };
}
