{ pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  # TODO: apply links fix from https://nixos.wiki/wiki/Discord
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
