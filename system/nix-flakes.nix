{ pkgs, ... }:

{
  nix = {
    package = pkgs.nixVersions.stable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';

    registry = {
      sys.to = { path = "/home/noobstar/Projects/system-config"; type = "path"; };
    };
  };
}
