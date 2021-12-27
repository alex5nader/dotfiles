{ currentDevice, lib, ... }:

let
  inherit (lib) mkIf mkMerge;
in

mkMerge [
  (mkIf (currentDevice == "laptop") {
    fileSystems."/" = {
      device = "/dev/disk/by-uuid/1518a8cd-966d-4a21-9c29-7323cd0e242a";
      fsType = "ext4";
    };

    fileSystems."/boot" = {
      device = "/dev/disk/by-uuid/4C26-E73E";
      fsType = "vfat";
    };

    swapDevices = [
      { device = "/dev/disk/by-uuid/cf644972-23ea-4182-adfe-3cafdbf4588b"; }
    ];
  })

  (mkIf (currentDevice == "desktop") {
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
  })
]