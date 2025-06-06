{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.useOSProber = true;
  boot.loader.grub.timeoutStyle = "hidden";

  boot.loader.grub.gfxmodeEfi = "2560x720";
  boot.loader.grub.gfxmodeBios = "2560x720";

  boot.plymouth = {
    enable = true;
  };
}

