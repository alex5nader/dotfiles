{ config, mkIfDevice, lib, pkgs, ... }:

let
  inherit (lib) mkMerge optionalString;
in

mkMerge [
  (mkIfDevice "laptop" {
    services.xserver.desktopManager.budgie.extraGSettingsOverrides = ''
      [org.gnome.desktop.interface]
      text-scaling-factor = 1.5
    '';
  })

  (mkIfDevice "desktop" {
    boot.initrd.kernelModules = [ "amdgpu" ];
    services.xserver.videoDrivers = [ "amdgpu" ];

    services.autorandr = {
      enable = true;
      profiles = {
        main = {
          fingerprint = {
            "DP-2" = "00ffffffffffff0010acb8a055303131031c0104a53420783a0495a9554d9d26105054a54b00714f8180a940d1c0d100010101010101283c80a070b023403020360006442100001e000000ff00434656394e38314a313130550a000000fc0044454c4c2055323431350a2020000000fd00313d1e5311000a202020202020016002031cf14f9005040302071601141f12132021222309070783010000023a801871382d40582c450006442100001e011d8018711c1620582c250006442100009e011d007251d01e206e28550006442100001e8c0ad08a20e02d10103e96000644210000180000000000000000000000000000000000000000000000000000000c";
            "DP-4" = "00ffffffffffff000469ec27cca90200271c0104a53c227806ee91a3544c99260f505421080001010101010101010101010101010101565e00a0a0a029503020350056502100001a000000ff002341535055332b4e3363784464000000fd001e9022de3b010a202020202020000000fc00524f47205047323739510a2020011f020312412309070183010000654b040001015a8700a0a0a03b503020350056502100001a5aa000a0a0a046503020350056502100001a6fc200a0a0a055503020350056502100001a22e50050a0a0675008203a0056502100001e1c2500a0a0a011503020350056502100001a0000000000000000000000000000000000000019";
          };

          config."DP-2" = {
            enable = true;
            crtc = 1;
            mode = "1920x1200";
            position = "0x0";
            rate = "59.95";
          };

          config."DP-4" = {
            enable = true;
            crtc = 0;
            mode = "2560x1440";
            position = "1920x0";
            primary = true;
            rate = "144.00";
          };
        };
      };
    };

    # Necessary until https://github.com/NixOS/nixpkgs/issues/247434 is fixed.
    systemd.services.autorandr-startup = {
      description = "autorandr";
      after = [ "graphical-session-pre.target" ];
      partOf = [ "graphical-session.target" ];
      wantedBy = [ "graphical-session.target" ];

      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${pkgs.autorandr}/bin/autorandr --change ${
          optionalString config.services.autorandr.ignoreLid "--ignore-lid"
        }";
      };
    };
  })
]
