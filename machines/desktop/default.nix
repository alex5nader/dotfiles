{
  imports = [
    ../common.nix
    ./hardware.nix
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
  

  # Use Nvidia proprietary drivers
  hardware.nvidia.modesetting.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];


  # NixOS Version
  system.stateVersion = "20.09";
}