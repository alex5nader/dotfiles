{ stdenv, lib, makeDesktopItem, copyDesktopItems
, autoPatchelfHook, makeWrapper
, glibc, zlib, xorg }:

stdenv.mkDerivation rec {
  pname = "warp-randomizer";
  version = "1.0.3";

  src = ./src;

  desktopItems = [ (makeDesktopItem {
    name = "WarpRandomizerMain";
    exec = "WarpRandomizerMain";
    icon = "WarpRandomizerMain";
    desktopName = "Pokémon Warp Randomizer";
    comment = "Tool to randomize all warps in a Pokémon game";
    categories = "Game;";
  }) ];

  nativeBuildInputs = [ autoPatchelfHook makeWrapper copyDesktopItems ];
  buildInputs = [ glibc zlib xorg.libxcb ];

  installPhase = ''
    mkdir -p $out/bin
    cp $src/WarpRandomizerMain $out/bin
    
    mkdir -p $out/share/icons/hicolor/32x32/apps
    cp $src/icon.png $out/share/icons/hicolor/32x32/apps/WarpRandomizerMain.png

    runHook postInstall
  '';

  postFixup = ''
    wrapProgram $out/bin/WarpRandomizerMain \
      --set LD_LIBRARY_PATH ${lib.makeLibraryPath [xorg.libxcb]}
  '';
}