{
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  hardware.pulseaudio.enable = false;

  environment.etc = {
    "pipewire/pipewire.conf.d/99-custom.conf".text = ''
      {
        "context.properties": {
          "module.x11.bell": false 
        }
      }
    '';
  };
}
