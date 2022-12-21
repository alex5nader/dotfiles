self: super:

{
  # IMPORTANT: channel named nixos-unstable must exist. Use `nix-channel --add https://nixos.org/channels/nixos-unstable nixos-unstable`
  unstable = import <nixos-unstable> { config = super.config; };
}