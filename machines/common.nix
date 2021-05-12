{
  sound.enable = true;
  hardware.pulseaudio.enable = true;


  security.sudo.enable = false;


  services.xserver = {
    enable = true;
    desktopManager.gnome3.enable = true;
    displayManager.gdm.enable = true;
  };
}