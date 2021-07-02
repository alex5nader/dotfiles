let
  overlays = [
    ./budgie.nix
    ./discord.nix
    ./moka-icon-theme.nix
    ./unstable.nix
    ./vscode-extensions.nix
  ];
in
map import overlays
