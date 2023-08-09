# TODO: convert to buildPythonApplication

{ stdenv, fetchFromGitHub
, python38 }:

stdenv.mkDerivation rec {
  pname = "splatnet2statink";
  version = "1.8.2";

  ver = version;


  format = "other";
  src = fetchFromGitHub {
    owner = "alex5nader";
    repo = "splatnet2statink";
    rev = "v${version}";
    sha256 = "wA9oYydjvjhqq+4NUw7BklH7gEEZIpM+ZOOhkQvW1Cg=";
  };

  # patches = [
  #   ./0001-change-past-to-future.patch
  #   ./0002-use-user-data-dir-for-config.patch
  #   ./0003-use-splitext-for-user-agent-verification.patch
  #   ./0004-tolerate-network-failure.patch
  # ];


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
