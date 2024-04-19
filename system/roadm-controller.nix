{ pkgs, stateVersion }:
{ lib, ... }:

let
  kea-config = {
    interfaces-config = {
      interfaces = ["eth0"];
      service-sockets-max-retries = 5;
      service-sockets-require-all = true;
    };
    rebind-timer = 2000;
    renew-timer = 1000;
    valid-lifetime = 4000;
    lease-database = {
      persist = true;
      type = "memfile";
    };
  };
  pythonEnv = with pkgs; python3.withPackages (p: with p; [
    netconf-client
  ]);
in

{
  system.stateVersion = stateVersion;
  nixpkgs.pkgs = pkgs;

  environment.systemPackages = with pkgs; [ tcpdump git pythonEnv ];

  networking.defaultGateway = "10.7.0.1";

  boot.kernel.sysctl = {
    "net.ipv6.conf.all.forwarding" = true;
  };

  services.openssh.enable = true;
  users.users.admin = {
    group = "admin";
    password = "admin";
    isNormalUser = true;
  };
  users.groups.admin = {};

  services.radvd.enable = true;
  services.radvd.config = ''
    interface eth0 {
      AdvSendAdvert on;
      prefix fc00:beef::/64 {};
    };
  '';

  services.kea = {
    dhcp4.enable = true;
    dhcp4.settings = lib.recursiveUpdate kea-config {
      lease-database.name = "/var/lib/kea/dhcp4.leases";
      subnet4 = [
        {
          id = 1;
          pools = [
            { pool = "10.7.0.100 - 10.7.0.199"; }
          ];
          subnet = "10.7.0.0/24";
        }
      ];
    };
    dhcp6.enable = true;
    dhcp6.settings = lib.recursiveUpdate kea-config {
      lease-database.name = "/var/lib/kea/dhcp6.leases";
      subnet6 = [
        {
          id = 2;
          pools = [
            { pool = "fc00:beef:: - fc00:beef::ffff"; }
          ];
          subnet = "fc00:beef::/64";
          interface = "eth0";
        }
      ];
    };
  };
}
