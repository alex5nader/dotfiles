{ pkgs, lib, ... }:

with lib;
with hm.gvariant;

let
  keybindings = [
    {
      name = "open-terminal";
      binding = "<Super>Return";
      command = "${pkgs.gnome3.gnome-terminal}/bin/gnome-terminal";
    }
    {
      name = "trigger-flameshot";
      binding = "<Super><Shift>s";
      command = "${pkgs.flameshot}/bin/flameshot gui";
    }
  ];


  getPath = keybinding: "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/" + keybinding.name;

  mkKeybindingEntry = keybinding: { ${getPath keybinding} = keybinding; };
  keybindingEntries = (lists.foldr recursiveUpdate {} (lists.map mkKeybindingEntry keybindings));

  paths = lists.map (keybinding: "/" + getPath keybinding + "/") keybindings;
  pathsEntry = {
    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = mkArray type.string paths;
    };
  };
in
recursiveUpdate pathsEntry keybindingEntries