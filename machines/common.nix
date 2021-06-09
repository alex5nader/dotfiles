{ pkgs, ... }:

{
  sound.enable = true;
  hardware.pulseaudio.enable = true;


  services.pcscd.enable = true;


  i18n.inputMethod = {
    enabled = "ibus";
    ibus.engines = with pkgs.ibus-engines; [ mozc ];
  };


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


  services.openvpn.servers = {
    nord-us = {
      config = "config ${./vpn/nord-us6898.ovpn}";
      autoStart = false;
    };
  };
}
