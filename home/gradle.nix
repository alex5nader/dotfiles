{ my-jdks, ... }:

{
  home.file = {
    gradle-properties = {
      text = ''
        org.gradle.java.home=${my-jdks.jdk17}
      '';
      target = ".gradle/gradle.properties";
    };
  };
}