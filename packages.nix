{ pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  # TODO: apply links fix from https://nixos.wiki/wiki/Discord
  environment.systemPackages = with pkgs; [
    # general usage
    firefox discord

    # programming
    vscode git

    # system management
    pciutils glxinfo
  ];


  programs.gnupg.agent = {
    enable = true;
    pinentryFlavor = "gnome3";
  };
}
