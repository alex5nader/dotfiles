{
  device-config.desktop = {
    time.timeZone = "America/Chicago";

    i18n.defaultLocale = "en_US.UTF-8";
    services.xserver.layout = "us";
    console = {
      font = "Lat2-Terminus16";
      keyMap = "us";
    };
  };

  device-config.laptop = {
    time.timeZone = "America/Chicago";

    i18n.defaultLocale = "en_US.UTF-8";
    services.xserver.layout = "us";
    console = {
      font = "Lat2-Terminus16";
      keyMap = "us";
    };
  };
}