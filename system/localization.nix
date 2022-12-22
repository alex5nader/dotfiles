{ mkIfDevice, lib, ... }:

let
  inherit (lib) mkIf mkMerge;
in

mkMerge [
  (mkIfDevice "laptop" {
    time.timeZone = "Asia/Tokyo";

    i18n.defaultLocale = "en_US.UTF-8";
    services.xserver.layout = "us";
    console = {
      font = "Lat2-Terminus16";
      keyMap = "us";
    };
  })
  
  (mkIfDevice "desktop" {
    time.timeZone = "America/Chicago";

    i18n.defaultLocale = "en_US.UTF-8";
    services.xserver.layout = "us";
    console = {
      font = "Lat2-Terminus16";
      keyMap = "us";
    };
  })
]