{ lib, config }:

with lib;
let
  current-device = config.current-device;
  cfgs = config.device-config;
in

{
  options.current-device = mkOption {
    type = types.str;
  };
  options.device-config = mkOption {
    type = types.attrs; # non homogenous so not using types.attrsOf types.inferred
  };

  config = cfgs.${current-device};
}