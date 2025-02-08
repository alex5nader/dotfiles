{ mkIfDevice, ... }:

mkIfDevice "desktop" {
  services.jellyfin = {
    enable = true;
    openFirewall = true;
  };
}
