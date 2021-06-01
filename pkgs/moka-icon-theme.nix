{ stdenv, fetchurl, pkgconfig, meson, ninja, python3, gtk3-x11 }:

stdenv.mkDerivation rec {
  pname = "moka-icon-theme";
  version = "5.4.0";

  src = fetchurl {
    url = "https://github.com/snwh/${pname}/archive/refs/tags/v${version}.tar.gz";
    sha256 = "1nbwdjj268hxv9lfagd9aylily9f0hhallp841v0i3imljp84bmk";
  };

  nativeBuildInputs = [ pkgconfig meson ninja python3 gtk3-x11 ];

  postPatch = ''
    patchShebangs meson/post_install.py
  '';
}