{ pkgs, ... }:

{
  imports = [
    ./java.nix
    ./libimobiledevice.nix
  ];

  environment.systemPackages = with pkgs; [
    git

    man-pages man-pages-posix

    pciutils glxinfo ripgrep gnome.gnome-tweaks file
  ];

  documentation.dev.enable = true;

  programs.gnupg.agent.enable = true; # TODO: missing pinentryFlavor = "gnome3" -- is this necessary?
  programs.steam.enable = true;

  programs.javaPackages = {
    jdk8 = pkgs.openjdk8;
    jdk11 = pkgs.openjdk11;
    jdk17 = pkgs.openjdk17;
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
