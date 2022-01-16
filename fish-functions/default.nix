{ lib, ... }:

let
  inherit (builtins) readDir;
  inherit (lib) filterAttrs hasSuffix nameValuePair mapAttrs';

  makeFile = name: {
    target = ".config/fish/functions/${name}";
    source = ./. + "/${name}";
  };

  paths = readDir ./.;                                                                                     # get all files in current directory as list of { ${name} = "${type}"; }
  fishFiles = filterAttrs (name: _: hasSuffix ".fish" name) paths;                                         # keep only .fish files
  fishFunctions = mapAttrs' (name: _: nameValuePair ("fish-function-${name}") (makeFile name)) fishFiles;  # convert from { ${name} = "${path}"; } to { "fish-function-${name}" = { source = ${path}; target = ".config/fish/functions/${name}"; }; }
in
{
  home.file = fishFunctions;
}
