{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  
  # Set up kernel modules
  boot.initrd.availableKernelModules = [ "xhci_pci" "thunderbolt" "nvme" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ "dm-snapshot" ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];


  # Set up partitions
  fileSystems."/" = {
    device = "/dev/disk/by-uuid/1518a8cd-966d-4a21-9c29-7323cd0e242a";
    fsType = "ext4";
  };

  fileSystem."/boot" = {
    device = "/dev/disk/by-uuid/4C26-E73E";
    fsType = "vfat";
  };

  swapDevices = [
    { device = "/dev/disk/by-uuid/cf644972-23ea-4182-adfe-3cafdbf4588b"; }
  ];


  # Misc
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  hardware.video.hidpi.enable = lib.mkDefault true;
  services.fprintd.enable = true;
}