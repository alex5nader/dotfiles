let
  overlays = [
    ./steam.nix
    ./vscode-extensions.nix
    ./warp-randomizer.nix
  ];
in
map import overlays
