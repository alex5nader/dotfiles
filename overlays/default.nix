let
  overlays = [
    ./budgie.nix
    ./discord.nix
    ./moka-icon-theme.nix
    ./steam.nix
    ./unstable.nix
    ./vscode-extensions.nix
    ./warp-randomizer.nix
  ];
in
map import overlays
