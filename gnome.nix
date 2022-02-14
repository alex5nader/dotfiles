{ pkgs, ... }:

{
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome = {
      enable = true;
      extraGSettingsOverrides = ''
        [org.gnome.desktop.wm.preferences]
        button-layout = ":minimize,maximize,close"
      '';
    };

    desktopManager.budgie.enable = true;
  };

  programs.gnupg.agent.pinentryFlavor = "gnome3";

  services.dbus.packages = [ pkgs.gnome.dconf ];
}