{ lib, pkgs }:

lib.makeScope pkgs.newScope (self: with self; {
  budgie-desktop = self.callPackage ./desktop.nix {};
  budgie-screensaver = self.callPackage ./screensaver {};
})