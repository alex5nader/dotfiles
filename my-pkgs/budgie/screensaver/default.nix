{ stdenv, fetchFromGitHub
, meson, ninja, pkg-config, cmake
, git, xorg, glib, dbus-glib, gtk3, gnome-desktop, gsettings-desktop-schemas, systemd, libgnomekbd, linux-pam, intltool
}:

stdenv.mkDerivation rec {
  pname = "budgie-screensaver";
  version = "5.1.0";

  src = fetchFromGitHub {
    owner = "BuddiesOfBudgie";
    repo = "budgie-screensaver";
    rev = "v${version}";
    sha256 = "N8x9hdbaMDisTbQPJedNO4UMLnCn+Q2hhm4udJZgQlc=";
  };

  nativeBuildInputs = [
    meson ninja pkg-config cmake
    git xorg.libX11 glib dbus-glib gtk3 gnome-desktop gsettings-desktop-schemas systemd libgnomekbd xorg.libXxf86vm linux-pam intltool
  ];

  patches = [
    ./0001-add-posix-source-define.patch
  ];
}