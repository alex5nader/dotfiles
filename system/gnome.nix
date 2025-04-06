{ mkIfDevice, lib, ... }:

let
  inherit (lib) mkMerge;
in

mkMerge [
  {
    services.xserver = {
      enable = true;

      desktopManager.budgie.enable = true;

    };
    services.libinput.enable = true;

    services.upower.enable = true; # Enable power display in panel
  }

  (mkIfDevice "laptop" {
    services.xserver.displayManager.lightdm.greeters.slick.extraConfig = ''
      enable-hidpi=on
    '';
  })
]
