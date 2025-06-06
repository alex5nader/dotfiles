{ buildDotnetModule, fetchFromGitHub
, copyDesktopItems, imagemagick, unzip, wrapGAppsHook, zip
, gtk3, libGL, xorg
, makeDesktopItem
}:

buildDotnetModule rec {
  pname = "stardrop";
  version = "1.2.1";

  src = fetchFromGitHub {
    owner = "Floogen";
    repo = "Stardrop";
    tag = "v${version}";
    sha256 = "sha256-VN0SrvBT5JUNraeh6YyRhcnoOl+mOB2/zk/rQeJidI8=";
  };

  projectFile = "Stardrop/Stardrop.csproj";
  nugetDeps = ./deps.json; # note: to generate this, path should be absolute so it doesn't get converted to a path in the /nix store
  selfContainedBuild = true;

  nativeBuildInputs = [
    copyDesktopItems wrapGAppsHook 
    imagemagick unzip zip
  ];
  runtimeDeps = [
    gtk3
    libGL
    # these are all copied from bevy
    # not sure exactly why, but right clicking is broken unless they are here
    # and I didn't try to figure out which are actually needed
    xorg.libX11 xorg.libXcursor xorg.libXi xorg.libXrandr
  ];

  patches = [
    ./0001-remove-hardcoded-paths.patch
  ];

  postInstall = ''
    # Stardrop builds a zip directly for some reason
    unzip "$out/lib/stardrop/Stardrop-linux-x64.zip" "Stardrop/*" -d "$out/lib/stardrop"
    rm "$out/lib/stardrop/Stardrop-linux-x64.zip"

    # idk how to unzip without the inner folder
    mv "$out"/lib/stardrop/Stardrop/* "$out/lib/stardrop"
    rmdir "$out/lib/stardrop/Stardrop"

    # get rid of pointless wrapper script
    rm "$out/lib/stardrop/Stardrop.sh"
    mv "$out/lib/stardrop/Internal" "$out/lib/stardrop/stardrop"

    # Stardrop doesn't build an executable that's allowed to execute
    chmod +x "$out/lib/stardrop/stardrop"

    # create icons
    for size in 16 24 32 48 64 128 256 512; do
      mkdir -p "$out"/share/icons/hicolor/"$size"x"$size"/apps
      magick convert -interpolate Integer -filter point -resize "$size"x"$size" Stardrop/Assets/icon.ico "$out"/share/icons/hicolor/"$size"x"$size"/apps/stardrop.png
    done
  '';

  executables = [ "stardrop" ];

  desktopItems = [
    (makeDesktopItem {
      name = "stardrop";
      desktopName = "Stardrop";
      exec = "stardrop";
      icon = "stardrop";
    })
  ];
}
