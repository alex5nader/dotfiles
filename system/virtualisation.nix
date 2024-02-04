{ mkIfDevice, lib, pkgs, ... }:

let
  inherit (lib) mkIf mkMerge;
in

mkMerge [
  {
    virtualisation.libvirtd.enable = true;
    virtualisation.spiceUSBRedirection.enable = true;
    environment.systemPackages = with pkgs; [ virt-manager spice-gtk ];

    users.users.noobstar.extraGroups = [ "libvirtd" ];
  }

  (mkIfDevice "desktop" {
    boot.kernelModules = [ "vfio-pci" ];
    boot.kernelParams = [ "iommu=pt" "amd_iommu=on" "rd.driver.pre=vfio-pc" ];
  })
]
