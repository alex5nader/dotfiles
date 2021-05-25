{ lib }:

with lib.lists;
with lib.hm.gvariant;

{
  "org/gnome/desktop/input-sources" = {
    sources = map mkTuple [
      [ "xkb" "us" ]
      [ "ibus" "mozc-jp" ]
    ];
  };
  "org/gnome/desktop/interface" = {
    gtk-im-module = "ibus";
  };
}
