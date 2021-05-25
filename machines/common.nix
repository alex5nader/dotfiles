{
  sound.enable = true;
  hardware.pulseaudio.enable = true;


  services.pcscd.enable = true;


  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome3 = {
      enable = true;
      extraGSettingsOverrides = ''
        [org.gnome.desktop.wm.preferences]
        button-layout = ":minimize,maximize,close"
      '';
    };
  };
}
