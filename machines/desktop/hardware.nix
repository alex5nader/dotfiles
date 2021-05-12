{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];


  # Set up kernel modules
  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [ "dm-snapshot" ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];


  # Set up partitions
  fileSystems."/" = {
    device = "/dev/disk/by-uuid/84e2af52-d773-45a7-a27b-9db7af9340e9";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/7DD6-0FB7";
    fsType = "vfat";
  };

  swapDevices = [
    { device = "/dev/disk/by-uuid/43152cf2-0142-41ba-8206-986cb9bc6e9b"; }
  ];
}