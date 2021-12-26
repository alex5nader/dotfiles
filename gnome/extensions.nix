{ pkgs, ... }:

{
  environment.systemPackages = with pkgs.gnomeExtensions; [
    arcmenu user-themes appindicator workspace-switch-wraparound
    no-overview
    dash-to-panel
  ];
}