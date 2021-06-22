{ pkgs }:

with pkgs;

let 
  libpulseaudio = pkgs.libpulseaudio.overrideAttrs (old: {
    postInstall = ''
      find $out/share -maxdepth 1 -mindepth 1 ! -name "vala" -prune -print -exec rm -r {} \;
      find $out/share/vala -maxdepth 1 -mindepth 1 ! -name "vapi" -prune -print -exec rm -r {} \;
      [ -d $out/lib/systemd ] && rm -r $out/lib/systemd
    '' + (builtins.replaceStrings ["rm -rf $out/{bin,share,etc,lib/{pulse-*,systemd}}"] ["rm -r $out/{bin,etc,lib/pulse-*}"] old.postInstall);
  });
in

stdenv.mkDerivation rec {
  pname = "budgie-desktop";
  version = "10.5.3";
  src = fetchurl {
    url = "https://github.com/solus-project/${pname}/releases/download/v${version}/${pname}-v${version}.tar.xz";
    sha256 = "878f4e6460c29740bf633c3b11ba97bcb788068c1460f82569938af2f1633b25";
  };

  patches = [
    ./add-missing-giounix-deps.patch # PR this eventually
  ]; 

  mesonFlags = [
    "-Dwith-gtk-doc=false" # TODO: figure out if this is fixable without disabling it entirely
  ];
  
  # dependencies taken from https://github.com/solus-project/budgie-desktop/wiki/Building-Budgie-Desktop
  nativeBuildInputs = [
    # from wiki
    # gtk_doc                       # gtk-doc -- disabled because idk how to fix it
    meson                         # meson
    sassc                         # sassc
    vala                          # vala

    # not listed on wiki
    pkg-config                    # locates listed dependencies
    intltool                      # only present in dependency install commands
    ninja                         # only present in dependency install commands
    desktop-file-utils            # provides update-desktop-database which is used in meson_post_install.sh
    makeWrapper                   # replaces env vars with ones to /nix/store
  ];
  buildInputs = [
    accountsservice               # accountsservice
    alsaLib                       # alsa-lib
    # gio-2.0                     # included in glib
    # gio-unix-2.0                # included in glib
    gnome.gnome-bluetooth         # gnome-bluetooth-1.0
    gnome.gnome-desktop           # gnome-desktop-3.0
    gnome.gnome-settings-daemon   # gnome-settings-daemon
    # gobject-2.0                 # included in glib
    gobjectIntrospection          # gobject-introspection
    gtk3-x11                      # gtk+-3.0
    ibus                          # ibus-1.0
    gnome-menus                   # libgnome-menu-3.0
    libnotify                     # libnotify
    gnome.libpeas                 # libpeas-gtk-1.0
    libpulseaudio                 # libpulse
    libwnck3                      # libwnck
    # meson                       # meson under nativeBuildInputs
    gnome.mutter                  # mutter
    # polkit-agent-1              # included in polkit
    # polkit-gobject-1            # included in polkit
    upower                        # upower-glib
    libuuid                       # uuid

    # not listed on wiki
    budgie.budgie-screensaver     # just not listed for some reason
    glib                          # provides gio-2.0, gio-unix-2.0, gobject-2.0
    polkit                        # provides polkit-agent-1, polkit-gobject-1
  ];
}
