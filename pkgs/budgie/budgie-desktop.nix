{ pkgs }:

with pkgs;

stdenv.mkDerivation rec {
  pname = "budgie-desktop";
  version = "10.5.3";
  src = fetchurl {
    url = "https://github.com/solus-project/${pname}/releases/download/v${version}/${pname}-v${version}.tar.xz";
    sha256 = "878f4e6460c29740bf633c3b11ba97bcb788068c1460f82569938af2f1633b25";
  };

  nativeBuildInputs = [ meson ninja sassc gtk_doc pkg-config ];
  buildInputs = [ gtk3-x11 glib gnome3.libpeas libuuid vala ibus libnotify gnome3.gnome-desktop gsettings_desktop_schemas gnome3.gnome-settings-daemon libwnck3 accountsservice budgie.budgie-screensaver intltool x11 graphene gnome3.mutter gnome3.gnome-bluetooth upower polkit gnome-menus libpulseaudio alsaLib cmake ];
  
  dontInstall = true;
  dontFixup = true;
  dontCopydist = true;
}