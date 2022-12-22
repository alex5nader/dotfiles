{ mkIfDevice, lib, ... }:

let
  inherit (lib) mkIf mkMerge;
in

mkMerge [
  (mkIfDevice "laptop" {
    networking.hostName = "noobstar-laptop";

    system.stateVersion = "21.11";
  })

  (mkIfDevice "desktop" {
    networking.hostName = "noobstar-pc";

    system.stateVersion = "20.09";
  })
]