{ lib, pkgs, budgie, ... }:

with lib;

{
  options = {
    services.xserver.displayManager.lightdm.greeters.slick.cursorTheme.name = mkOption {
      type = types.str;
      default = "";
    };
    services.xserver.displayManager.lightdm.greeters.slick.cursorTheme.package = mkOption {
      type = types.package;
    };
  };

  config = {
    services.xserver = {
      enable = true;
      # displayManager.gdm = {
      #   enable = true;
      #   wayland = false;
      # };
      # displayManager.lightdm.enable = true;

      # desktopManager.gnome = {
      #   enable = true;
      #   extraGSettingsOverrides = ''
      #     [org.gnome.desktop.wm.preferences]
      #     button-layout = ":minimize,maximize,close"
      #   '';
      # };

      desktopManager.budgie.enable = true;
      libinput.enable = true;
    };

    # programs.gnupg.agent.pinentryFlavor = "gnome3";

    # services.dbus.packages = [ pkgs.dconf ];
  };
}
