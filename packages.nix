{ config, pkgs, ... }:

{
  nixpkgs.config = {
    allowUnfree = true;
    packageOverrides = pkgs: {
      # IMPORTANT: channel named nixpkgs-unstable must exist. Use `nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs-unstable`
      unstable = import <nixpkgs-unstable> { config = config.nixpkgs.config; };

      discord = pkgs.discord.override {
        nss = pkgs.nss_latest;
      };
    };
  };

  environment.systemPackages = with pkgs; [
    # programming
    git vscode

    # admin
    pciutils glxinfo ripgrep gnome3.gnome-tweak-tool
  ];

  programs.gnupg.agent = {
    enable = true;
    pinentryFlavor = "gnome3";
  };

  programs.steam.enable = true;

  services.dbus.packages = with pkgs; [ gnome3.dconf ];
}
