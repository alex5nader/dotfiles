let
  overlays = [
    ./budgie.nix
    ./discord.nix
    ./unstable.nix
  ];
in
map import overlays