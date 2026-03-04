{ mkIfDevice, lib, ... }:

let
  inherit (lib) mkMerge;
in

mkMerge [
  {
    networking.useDHCP = false;

    services.tailscale.enable = true;
  }

  (mkIfDevice "laptop" {
    networking.interfaces.wlp170s0.useDHCP = true;
    
    # laptop wifi is slow unless powersave is disabled
    networking.networkmanager.wifi.powersave = false;
  })
]
