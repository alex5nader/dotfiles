{ lib, pkgs, ... }:

{
  imports = [ ./binds.nix ];

  programs.niri.settings = {
    environment = {
      DISPLAY = ":123";
      NIXOS_OZONE_WL = "1";
    };
  
    spawn-at-startup = [
      { command = [ "${pkgs.xwayland-satellite}/bin/xwayland-satellite" ":123" ]; }
      { command = [ "${pkgs.swww}/bin/swww-daemon" ]; }
    ];

    layout = {
      border.enable = false;
      focus-ring.enable = true;
      focus-ring.active.gradient = {
        from = "#bf616a";
        to = "#bf616a";
        angle = 225;
        in' = "oklch longer hue";
        relative-to = "workspace-view";
      };
    };

    window-rules = [
      {
        geometry-corner-radius = let r = 12.0; in {
          top-left = r;
          top-right = r;
          bottom-left = r;
          bottom-right = r;
        };
        clip-to-geometry = true;
      }
      {
        matches = [
          { app-id = "firefox"; title = "^$"; }
          { app-id = "firefox"; title = ''^Extension: \(Bitwarden Password Manager\)''; }
          { app-id = "firefox"; title = "Picture-in-Picture"; }
          { app-id = "Stardrop"; title = "Settings|Profiles|Warning|Message|Profile Name|stardrop"; }
        ];
        open-floating = true;
      }
      {
        matches = [
          { app-id = "steam_app_3014080"; }
        ];
        open-fullscreen = true;
      }
    ];

    input = {
      focus-follows-mouse.enable = true;
    };
  };

  programs.fuzzel.enable = true;
  programs.fuzzel.settings = {
    main.font = lib.mkForce "monospace:size=16";
    main.icon-theme = "Papirus";
    main.line-height = 36;
  };

  services.playerctld.enable = true;

  home.packages = with pkgs; [ playerctl xwayland-satellite wl-clipboard-rs ];
}
