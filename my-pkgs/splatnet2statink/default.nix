# TODO: convert to buildPythonApplication

{ stdenv, fetchFromGitHub
, python38 }:

stdenv.mkDerivation rec {
  pname = "splatnet2statink";
  version = "1.7.1";


  format = "other";
  src = fetchFromGitHub {
    owner = "frozenpandaman";
    repo = "splatnet2statink";
    rev = "v${version}";
    sha256 = "109frj8vkbbgk058xxwijgc681cb31fbdjnl50j0ssfha2nnq96k";
  };

  patches = [
    ./0001-change-past-to-future.patch
    ./0002-use-user-data-dir.patch
    ./0003-use-splitext-for-user-agent-verification.patch
    ./0004-tolerate-network-failure.patch
  ];


  buildInputs = [
    (python38.withPackages (python38Packages: with python38Packages; [
      beautifulsoup4
      requests
      msgpack
      future
      pillow
      packaging
      
      appdirs # used in patch 0002
    ]))
  ];


  unpackPhase = ''
    cp $src/*.py .
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp * $out/bin
    mv $out/bin/splatnet2statink.py $out/bin/splatnet2statink
  '';
}