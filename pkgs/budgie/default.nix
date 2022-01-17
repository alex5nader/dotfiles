{ lib, pkgs }:

lib.makeScope pkgs.newScope (self: with self; {
  budgie-desktop = self.callPackage ./desktop {};
  budgie-screensaver = self.callPackage ./screensaver.nix {};

  budgie-mutter = pkgs.gnome.callPackage ./mutter {};
})