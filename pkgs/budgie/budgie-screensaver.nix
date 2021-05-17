{ pkgs }:

with pkgs;

stdenv.mkDerivation rec {
  pname = "budgie-screensaver";
  version = "4.0";
  src = fetchurl {
    url = "https://github.com/getsolus/${pname}/releases/download/v${version}/${pname}-v${version}.tar.xz";
    sha256 = "dde83f355e549b5f6290655f33acd910d2febbb8fd974f922b14814054f80f49";
  };
  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ intltool glib x11 gtk3-x11 gnome3.gnome-desktop gsettings_desktop_schemas dbus-glib linux-pam ];
}
