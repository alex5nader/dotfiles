{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    libimobiledevice
  ];

  services.usbmuxd = {
    user = "root";
    group = "root";
    enable = true;
  };
}