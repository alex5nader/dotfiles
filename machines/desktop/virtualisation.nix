{ pkgs, ... }:

{
  boot.kernelParams = [ "iommu=pt" "amd_iommu=on" "rd.driver.pre=vfio-pc" ];

  virtualisation.libvirtd = {
    enable = true;
  };

  environment.systemPackages = [ pkgs.virt-manager ];
}