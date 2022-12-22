{ mkIfDevice, pkgs, ... }:

let
  inherit (pkgs) splatnet2statink;
in

mkIfDevice "desktop" {
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