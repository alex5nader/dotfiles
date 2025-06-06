{ mkIfDevice, lib, ... }:

let
  inherit (lib) mkMerge;
in

mkMerge [
  {
    # yubikey
    services.pcscd.enable = true;

    hardware.enableRedistributableFirmware = lib.mkDefault true;

    services.fwupd.enable = true;
  }

  (mkIfDevice "laptop" {
    # Framework config added in flake.nix via nixos-hardware
  
    powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  })
]

