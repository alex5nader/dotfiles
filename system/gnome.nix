{ lib, pkgs, ... }:

with lib;

{
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

    services.upower.enable = true; # Enable power display in panel

    # programs.gnupg.agent.pinentryFlavor = "gnome3";

    # services.dbus.packages = [ pkgs.dconf ];
  };
}
