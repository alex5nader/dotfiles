self: super:

{
  # IMPORTANT: channel named nixpkgs-unstable must exist. Use `nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs-unstable`
  unstable = import <nixpkgs-unstable> { config = super.config; };
}