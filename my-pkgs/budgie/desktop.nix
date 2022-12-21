{ stdenv, fetchFromGitHub
, meson, ninja, cmake, pkg-config, intltool
, sassc, vala
, budgie
, accountsservice, alsa-lib, glib, gnome, gtk3, ibus, gnome-menus
, libnotify, libpeas, libpulseaudio, libwnck, polkit, upower, libuuid
, gobject-introspection, gnome-desktop
, mesa
}:

stdenv.mkDerivation rec {
  pname = "budgie";
  version = "10.6.4";

  src = fetchFromGitHub {
    owner = "BuddiesOfBudgie";
    repo = "budgie-desktop";
    rev = "v${version}";
    fetchSubmodules = true;
    sha256 = "JfCKUNNdbyXvexrWWip8EpWVaW+PpwQ0vkrpr6M41ds=";
  };

  passthru = {
    providedSessions = [ "budgie-desktop" ];
  };


  mesonFlags = [
    "-Dwith-gtk-doc=false"
  ];

  nativeBuildInputs = [
    meson ninja cmake pkg-config intltool

    sassc vala
  ];

  buildInputs = [
    # From https://github.com/BuddiesOfBudgie/budgie-desktop/wiki/Building-Budgie-Desktop
    accountsservice # accountsservice >= 0.6.40
    alsa-lib # alsa-lib >= 1.1.0
    budgie.budgie-screensaver # budgie-screensaver (or gnome-screensaver on Debian / Ubuntu)
    glib # gio-2.0 >= 2.64.0
         # gio-unix-2.0 >= 2.64.0
         # gobject-2.0 >= 2.64.0
    gnome.gnome-bluetooth_1_0 # gnome-bluetooth-1.0 >= 3.34.0
    gnome-desktop # gnome-desktop-3.0 >= 41.0
    gnome.gnome-settings-daemon # gnome-settings-daemon >= 41.0
    gobject-introspection # gobject-introspection-1.0 >= 1.64.0
    gtk3 # gtk+-3.0 >= 3.24.0
    ibus # ibus-1.0 >= 1.5.10
    gnome-menus # libgnome-menu-3.0 >= 3.10.3
    libnotify # libnotify >= 0.7
    libpeas # libpeas-gtk-1.0 >= 1.26.0
    libpulseaudio # libpulse >= 2
    libwnck # libwnck >= 3.36.0
    gnome.mutter # mutter >= 41.0
    polkit # polkit-agent-1 >= 0.110
           # polkit-gobject-1 >= 0.110
    upower # upower-glib >= 0.99.0
    libuuid # uuid

    # Encountered while building
    mesa
  ];
}