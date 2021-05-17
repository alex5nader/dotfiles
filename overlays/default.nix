let
  overlays = [
    ./discord.nix
    ./unstable.nix
  ];
in
map import overlays