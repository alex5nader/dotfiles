{ config, mkIfDevice, lib, ... }:

let
  inherit (lib) mkIf mkMerge;
in

mkMerge [
  {
    # yubikey
    services.pcscd.enable = true;
    
    hardware.enableRedistributableFirmware = lib.mkDefault true;
  }

  (mkIfDevice "laptop" {
    powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
    hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    hardware.video.hidpi.enable = lib.mkDefault true;
    services.fprintd.enable = true;
  })
]