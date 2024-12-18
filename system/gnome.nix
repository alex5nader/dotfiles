{
  config = {
    services.xserver = {
      enable = true;

      desktopManager.budgie.enable = true;
    };
    services.libinput.enable = true;

    services.upower.enable = true; # Enable power display in panel
  };
}
