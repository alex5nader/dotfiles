{
  networking.useDHCP = false;

  device-config.laptop = {
    networking.interface.wlp170s0.useDHCP = true;
  };
  
  device-config.desktop = {
    networking.interfaces.enp33s0.useDHCP = true;
  };
}