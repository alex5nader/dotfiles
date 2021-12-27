{ currentDevice, lib, ... }:

let
  inherit (lib) mkIf mkMerge;
in

mkMerge [
  (mkIf (currentDevice == "laptop") {
    networking.hostName = "noobstar-laptop";

    system.stateVersion = "21.11";
  })

  (mkIf (currentDevice == "desktop") {
    networking.hostName = "noobstar-pc";

    system.stateVersion = "20.09";
  })
]