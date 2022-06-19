pkgs:

let
  extensions = pkgs.gnomeExtensions;
  unstable = pkgs.unstable.gnomeExtensions;
in

with extensions;

[
  arcmenu user-themes appindicator workspace-switch-wraparound
  no-overview
  dash-to-panel
]