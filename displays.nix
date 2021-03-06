{ config, currentDevice, lib, pkgs, ... }:

let
  inherit (lib) mkIf mkMerge;
in

mkMerge [
  (mkIf (currentDevice == "laptop") {
    services.xserver.desktopManager.gnome.extraGSettingsOverrides =
      mkIf config.services.xserver.desktopManager.gnome.enable ''
        [org.gnome.desktop.interface]
        text-scaling-factor = 1.5
      '';
  })

  (mkIf (currentDevice == "desktop") {
    hardware.nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      modesetting.enable = true;
    };

    services.xserver = {
      videoDrivers = [ "nvidia" ];
      # must keep in sync with monitors.xml!!!
      xrandrHeads = [
        "DP-4.8"
        { output = "DP-4.1"; primary = true; }
        # {
        #   output = "DP-2";
        #   monitorConfig = ''
        #     Modeline "1920x1200_60.00" 193.16 1920 2048 2256 2592 1200 1201 1204 1242 -HSync +Vsync
        #     Option "PreferredMode" "1920x1200_60.00"
        #   '';
        # }
        # {
        #   output = "DP-4";
        #   primary = true;
        #   monitorConfig = ''
        #     ModeLine "2560x1440_144.00"  807.69  2560 2784 3072 3584  1440 1441 1444 1565  -HSync +Vsync
        #     Option "PreferredMode" "2560x1440_144.00"
        #   '';
        # }
      ];
    };
  })
]