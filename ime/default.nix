{ lib, pkgs, ... }:

with lib.lists;
with lib.hm.gvariant;

{
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [ fcitx5-mozc fcitx5-gtk libsForQt5.fcitx5-qt ];
  };

  dconf.settings = {
    "org/gnome/desktop/wm/keybindings" = {
      switch-input-source = [];
      switch-input-source-backward = [];
    };

    "org/gnome/desktop/input-sources" = {
      sources = map mkTuple [
        [ "xkb" "us" ]
        [ "ibus" "mozc-jp" ]
      ];
    };
    "org/gnome/desktop/interface" = {
      gtk-im-module = "fcitx";
    };
  };
}
