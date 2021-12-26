{ config, lib, ... }:

with lib;

let
  cfg = config.programs.javaPackages;

  mkJdk = release: mkOption {
    type = types.unspecified // { merge = mergeEqualOption; };
    description = "Package used for JDK ${release}";
  };
in

{
  options = {
    programs.javaPackages = {
      jdk8 = mkJdk "8";
      jdk11 = mkJdk "11";
      jdk16 = mkJdk "16";
    };
  };

  config.environment = with cfg; {
    systemPackages = [ jdk8 jdk11 jdk16 ];
    etc = {
      "jdk8".source = jdk8;
      "jdk11".source = jdk11;
      "jdk16".source = jdk16;
    };
  };
}