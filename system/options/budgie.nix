# { config, lib, pkgs, budgie, ... }:

# with lib;

# let 
#   xcfg = config.services.xserver;
#   cfg = xcfg.desktopManager.budgie;
# in
# {
#   options = {
#     services.xserver.desktopManager.budgie.enable = mkEnableOption "Budgie desktop environment";
#   };

#   config = mkIf (xcfg.enable && cfg.enable) {
#     services.xserver.displayManager.sessionPackages = [ pkgs.budgie.budgie-desktop ];

#     environment.systemPackages = with pkgs; with gnome; [
#       gnome-session ibus
#     ];
#   };

# #   config = mkIf (xcfg.enable && cfg.enable) {
# #     security.polkit.enable = true;
# #     services.udisks2.enable = true;
# #     services.gvfs.enable = true;
# #     services.gnome.sushi.enable = mkDefault true;
# #     services.gnome.tracker.enable = mkDefault true;
# #     hardware.pulseaudio.enable = mkDefault true;
# #     services.telepathy.enable = mkDefault true;
# #     networking.networkmanager.enable = mkDefault true;
# #     services.upower.enable = config.powerManagement.enable;
# #     hardware.bluetooth.enable = mkDefault true;


# #     services.xserver.displayManager.sessionPackages = [ pkgs.budgie.budgie-desktop ];


# #     environment.systemPackages = with gnome; [
# #       pkgs.budgie.budgie-desktop pkgs.arc-theme pkgs.moka-icon-theme
# #       pkgs.desktop_file_utils pkgs.ibus pkgs.shared_mime_info glib gtk3
# #       glib_networking gvfs dconf gnome-backgrounds gnome_control_center
# #       gnome-menus gnome_settings_daemon gnome_themes_standard defaultIconTheme
# #       pkgs.hicolor_icon_theme empathy eog epiphany evince nautilus totem
# #       gnome-calculator gnome-screenshot gnome-system-monitor gnome_terminal
# #       file-roller gedit
# #       networkmanagerapplet pkgs.budgie.budgie-screensaver gnome.gnome-session ];

# #     environment.pathsToLink = [ "/share" ];
# #   };
# }
