{ mkIfDevice, lib, pkgs, ... }:

let
  inherit (lib) mkMerge;
in

mkMerge [
  {
    networking.useDHCP = false;

    services.globalprotect.enable = true;

    environment.systemPackages = with pkgs; [
      globalprotect-openconnect
    ];

    programs.mininet.enable = true;

    services.tailscale.enable = true;
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
