{ config, lib }:

let
  inherit (lib.attrsets) getBin;
in

[
  {
    name = "open-terminal";
    binding = "<Super>Return";
    command = "${getBin config.programs.wezterm.package}/bin/wezterm";
  }
  {
    name = "trigger-flameshot";
    binding = "<Super><Shift>s";
    command = "${getBin config.services.flameshot.package}/bin/flameshot gui";
  }
]
