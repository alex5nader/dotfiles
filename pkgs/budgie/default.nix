{ callPackage }:

{
  budgie-desktop = callPackage ./budgie-desktop { };
  budgie-screensaver = callPackage ./budgie-screensaver.nix { };
}
