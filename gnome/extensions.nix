pkgs:

let
  extensions = pkgs.gnomeExtensions;
  unstable = pkgs.unstable.gnomeExtensions;
in

with extensions;

[
  arcmenu-27 user-themes appindicator workspace-switch-wraparound
  no-overview
  dash-to-panel
]