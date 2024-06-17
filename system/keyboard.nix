{ pkgs, ... }:

{
  services.udev.packages = with pkgs; [ via ];

  environment.systemPackages = with pkgs; [ via ];
}
