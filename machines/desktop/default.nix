{ config, pkgs, ... }:

{
  imports = [
    ../common.nix
    ./hardware.nix
    ./virtualisation.nix
  ];


  # General machine info
  networking.hostName = "noobstar-pc";

  time.timeZone = "America/Chicago";

  i18n.defaultLocale = "en_US.UTF-8";
  services.xserver.layout = "us";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };
  

  # Display stuff
  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidia_x11_beta;
    modesetting.enable = true;
  };
  services.xserver = {
    videoDrivers = [ "nvidia" ];
    # must keep in sync with monitors.xml!!!
    xrandrHeads = [
      {
        output = "DP-2";
        monitorConfig = ''
          ModeLine "1920x1200_60.00"  193.16  1920 2048 2256 2592  1200 1201 1204 1242  -HSync +Vsync
          Option "PreferredMode" "1920x1200_60.00"
        '';
      }
      {
        output = "DP-4";
        primary = true;
        monitorConfig = ''
          ModeLine "2560x1440_144.00"  807.69  2560 2784 3072 3584  1440 1441 1444 1565  -HSync +Vsync
          Option "PreferredMode" "2560x1440_144.00"
        '';
      }
    ];
  };
 

  # NixOS Version
  system.stateVersion = "20.09";
}
