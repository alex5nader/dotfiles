{ currentDevice, lib, pkgs, ... }:

let
  inherit (lib) mkIf;
  inherit (pkgs) splatnet2statink;
in

mkIf (currentDevice == "desktop") {
  home.packages = [ splatnet2statink ];

  systemd.user.services = {
    splatnet2statink = {
      Unit = {
        Description = "splatnet2statink monitoring daemon";
      };

      Service = {
        Type = "simple";
        ExecStart = "${splatnet2statink}/bin/splatnet2statink -M 1800";
      };

      Install = {
        WantedBy = [ "default.target" ];
      };
    };
  };
}