{
  nix = {
    # package is now Lix, set by lix input

    extraOptions = ''
      experimental-features = nix-command flakes
    '';

    registry = {
      sys.to = { path = "/home/noobstar/Projects/system-config"; type = "path"; };
    };
  };
}
