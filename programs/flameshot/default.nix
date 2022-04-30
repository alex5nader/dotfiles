{
  services.flameshot.enable = true;

  home.file.flameshot-config = {
    source = ./config;
    target = ".config/flameshot/flameshot.ini";
  };
}