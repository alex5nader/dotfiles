{ pkgs, ... }:

{
  niri-flake.cache.enable = false;
  programs.niri = {
    enable = true;
    package = pkgs.niri-unstable;
  };

  services.xserver.displayManager.lightdm.greeters.slick.enable = false;
  programs.regreet.enable = true;

  xdg.portal.config = {
    niri = {
      "org.freedesktop.impl.portal.FileChooser" = [ "gtk" ];
    };
  };
}
