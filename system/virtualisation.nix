{ mkIfDevice, lib, pkgs, config, ... }:

let
  inherit (lib) mkIf mkMerge;
in

mkMerge [
  {
    virtualisation.libvirtd.enable = true;
    virtualisation.spiceUSBRedirection.enable = true;
    environment.systemPackages = with pkgs; [ virt-manager virtiofsd spice-gtk ];

    users.users.noobstar.extraGroups = [ "libvirtd" ];

    virtualisation.vswitch.enable = true;
    environment.etc = {
      "ila1-ifup".source = ./ovs/ila1-ifup;
      "ila1-ifdown".source = ./ovs/ila1-ifdown;
      "ila2-ifup".source = ./ovs/ila2-ifup;
      "ila2-ifdown".source = ./ovs/ila2-ifdown;
    };

    networking.networkmanager.unmanaged = [ "interface-name:ve-*" ];
    networking.nat = {
      enable = true;
      internalInterfaces = ["rc2"];
      externalInterface = mkMerge [
        (mkIfDevice "laptop" "wlp170s0")
        (mkIfDevice "desktop" "enp33s0")
      ];
    };

    containers.roadm-controller = {
        config = import ./roadm-controller.nix { inherit pkgs; inherit (config.system) stateVersion; };
        privateNetwork = true;
        localAddress = "10.7.0.1/32";
        localAddress6 = "fc00:beef::1";
        bindMounts = {
          "/root/client-test.py" = {
            hostPath = "/home/noobstar/Projects/osc/netconf-server/client-test.py";
            isReadOnly = false;
          };
        };
      };
  }

  {
    virtualisation.docker.enable = true;
    users.users.noobstar.extraGroups = ["docker"];
  }

  (mkIfDevice "desktop" {
    boot.kernelModules = [ "vfio-pci" ];
    boot.kernelParams = [ "iommu=pt" "amd_iommu=on" "rd.driver.pre=vfio-pc" ];
  })
]
