{
  boot.kernelParams = [ "pci=assign-busses,hpbussize=0x33,realloc,hpmmiosize=128M,hpmmioprefsize=1G" ];

  services.hardware.bolt.enable = true;
}

