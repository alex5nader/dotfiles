{ currentDevice, lib, ... }:

let
  inherit (lib) mkIf mkMerge;
in

mkMerge [
  {
    networking.useDHCP = false;
  }

  (mkIf (currentDevice == "laptop") {
    networking.interfaces.wlp170s0.useDHCP = true;
  })

  (mkIf (currentDevice == "desktop") {
    networking.interfaces.enp33s0.useDHCP = true;
  })
]