{ mkIfDevice, lib, ... }:

let
  inherit (lib) mkMerge;
in

mkMerge [
  (mkIfDevice "laptop" {
    time.timeZone = "America/Los_Angeles";

    i18n.defaultLocale = "en_US.UTF-8";
    services.xserver.xkb.layout = "us";
    console.keyMap = "us";
  })
  
  (mkIfDevice "desktop" {
    time.timeZone = "America/Los_Angeles";

    i18n.defaultLocale = "en_US.UTF-8";
    services.xserver.xkb.layout = "us";
    console.keyMap = "us";
  })
]
