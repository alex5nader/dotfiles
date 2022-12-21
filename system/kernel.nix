{ currentDevice, lib, pkgs, ... }:

let
  inherit (lib) mkIf mkMerge;
in

mkMerge [
  (mkIf (currentDevice == "laptop") {
    boot.kernelPackages = pkgs.linuxPackages_5_15;

    boot.initrd.availableKernelModules = [ "xhci_pci" "thunderbolt" "nvme" "usb_storage" "sd_mod" ];
    boot.initrd.kernelModules = [ "dm-snapshot" ];
    boot.kernelModules = [ "kvm-intel" ];
    boot.extraModulePackages = [ ];
  })

  (mkIf (currentDevice == "desktop") {
    boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" ];
    boot.initrd.kernelModules = [ "dm-snapshot" ];
    boot.kernelModules = [ "kvm-amd" ];
    boot.extraModulePackages = [ ];
  })
]