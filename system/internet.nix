{ mkIfDevice, lib, pkgs, ... }:

let
  inherit (lib) mkIf mkMerge;
in

mkMerge [
  {
    networking.useDHCP = false;

    services.globalprotect.enable = true;

    environment.systemPackages = with pkgs; [
      globalprotect-openconnect
    ];
  }

  (mkIfDevice "laptop" {
    networking.interfaces.wlp170s0.useDHCP = true;
    
    # laptop wifi is slow unless powersave is disabled
    networking.networkmanager.wifi.powersave = false;
  })

  (mkIfDevice "desktop" {
    networking.interfaces.enp33s0.useDHCP = true;
  })
]