{ pkgs, ... }:

{
  sound.enable = true;
  hardware.pulseaudio.enable = true;


  services.pcscd.enable = true;


  i18n.inputMethod = {
    enabled = "fcitx";
    fcitx.engines = with pkgs.fcitx-engines; [ mozc ];
  };


  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome = {
      enable = true;
      extraGSettingsOverrides = ''
        [org.gnome.desktop.wm.preferences]
        button-layout = ":minimize,maximize,close"
      '';
    };
    # desktopManager.budgie.enable = true;
  };


  services.openvpn.servers = {
    nord-us = {
      config = "config ${./vpn/nord-us6898.ovpn}";
      autoStart = false;
    };
  };
}
