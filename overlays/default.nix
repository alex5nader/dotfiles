let
  overlays = [
    ./budgie.nix
    ./discord.nix
    ./moka-icon-theme.nix
    ./unstable.nix
  ];
in
map import overlays