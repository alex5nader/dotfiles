{
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;

    extraConfig.pipewire = {
      "99-no-bell" = {
        "context.properties" = {
          "module.x11.bell" = false;
        };
      };
    };
  };

  hardware.pulseaudio.enable = false;
}
