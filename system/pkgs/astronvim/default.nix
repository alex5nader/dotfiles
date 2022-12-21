{ stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  pname = "astronvim";
  version = "1.9.0";

  src = fetchFromGitHub {
    owner = "AstroNvim";
    repo = "AstroNvim";
    rev = "v${version}";
    sha256 = "SDDiUSnrCrBvIezLnDxnFAwAdPNpCT3xBHvjf74xGpU=";
  };

  dontUnpack = true;
  dontPatch = true;
  dontConfigure = true;
  dontBuild = true;

  installPhase = ''
    mkdir $out
    cp -r $src/* $out
  '';
}
