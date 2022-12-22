{ stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  pname = "astronvim";
  version = "2.10.1";

  src = fetchFromGitHub {
    owner = "AstroNvim";
    repo = "AstroNvim";
    rev = "v${version}";
    sha256 = "xup1hYFepKFDs+PhO25u1OrSWlxGtIfJqLMFCqQK0Tg=";
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
