{ currentDevice, lib, ... }:

let
  inherit (lib) mkIf mkMerge;
in

mkMerge [
  (mkIf (currentDevice == "laptop") {
    time.timeZone = "Asia/Tokyo";

    i18n.defaultLocale = "en_US.UTF-8";
    services.xserver.layout = "us";
    console = {
      font = "Lat2-Terminus16";
      keyMap = "us";
    };
  })
  
  (mkIf (currentDevice == "desktop") {
    time.timeZone = "America/Chicago";

    i18n.defaultLocale = "en_US.UTF-8";
    services.xserver.layout = "us";
    console = {
      font = "Lat2-Terminus16";
      keyMap = "us";
    };
  })
]