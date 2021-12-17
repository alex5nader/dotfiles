{ config, pkgs, ... }:

{
  imports = [
    ../common.nix
    ./hardware.nix
  ];


  # General machine info
  networking.hostName = "noobstar-laptop";

  time.timeZone = "America/Chicago";

  i18n.defaultLocale = "en_US.UTF-8";
  services.xserver.layout = "us";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };


  # Display stuff



  # Required for wifi card
  boot.kernelPackages = pkgs.linuxPackages_5_15;


  # NixOS Version
  system.stateVersion = "21.11";
}