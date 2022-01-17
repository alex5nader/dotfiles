pkgs:

let
  extensions = pkgs.gnomeExtensions;
  unstable = pkgs.unstable.gnomeExtensions;
in

with extensions;

[
  unstable.arcmenu user-themes appindicator workspace-switch-wraparound
  no-overview
  dash-to-panel # not working on gnome 40 yet
]