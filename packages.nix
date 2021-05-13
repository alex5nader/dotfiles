{ pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  # TODO: apply links fix from https://nixos.wiki/wiki/Discord
  environment.systemPackages = with pkgs; [
    # programming
    git vscode

    # admin
    pciutils glxinfo ripgrep
  ];

  programs.gnupg.agent = {
    enable = true;
    pinentryFlavor = "gnome3";
  };

  services.dbus.packages = with pkgs; [ gnome3.dconf ];
}
