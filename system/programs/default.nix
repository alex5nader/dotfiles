{ pkgs, ... }:

{
  imports = [
    ./java.nix
    ./libimobiledevice.nix
  ];

  environment.systemPackages = with pkgs; [
    git

    man-pages man-pages-posix gnome.yelp

    pciutils glxinfo ripgrep gnome.gnome-tweaks file
  ];

  documentation.dev.enable = true;
  documentation.man.generateCaches = false;

  programs.gnupg.agent.enable = true; # TODO: missing pinentryFlavor = "gnome3" -- is this necessary?
  programs.steam.enable = true;

  programs.javaPackages = {
    jdk8 = pkgs.openjdk8;
    jdk11 = pkgs.openjdk11;
    jdk17 = pkgs.openjdk17;
  };

  programs.nix-ld.enable = true;

  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_15;
    authentication = ''
      host all all 127.0.0.1/32 trust
      host all all ::1/128      trust
    '';
  };

  # Block Steam from trying to connect to wifi
  # https://github.com/ValveSoftware/steam-for-linux/issues/7856#issuecomment-1327053152
  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if (action.id === "org.freedesktop.NetworkManager.settings.modify.system") {
        var name = polkit.spawn(["cat", "/proc/" + subject.pid + "/comm"]);
        if (name.includes("steam")) {
          polkit.log("ignoring steam NM prompt");
          return polkit.Result.NO;
        }
      }
    });
  '';
}
