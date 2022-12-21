{ pkgs, lib, ... }:

with lib;
with hm.gvariant;

let
  keybindings = import ./keybinds.nix pkgs;

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

{
  dconf.settings = recursiveUpdate pathsEntry keybindingEntries;
}