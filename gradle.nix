{ pkgs, ... }:

{
  home.file = {
    gradle-properties = {
      text = ''
        org.gradle.java.home=${pkgs.my-jdks.jdk16}
      '';
      target = ".gradle/gradle.properties";
    };
  };
}