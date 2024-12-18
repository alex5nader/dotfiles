{ pkgs, ... }:

{
  imports = [
    ./flameshot
    ./warp
    ./wezterm
    ./zellij

    ./chromium.nix
    ./direnv.nix
    ./eza.nix
    ./firefox.nix
    ./git.nix
    ./helix.nix
    ./home-manager.nix
    ./nix-index.nix
    ./opam.nix
    ./ssh.nix
    ./vscode.nix
  ];

  home.packages = with pkgs; with jetbrains; [
    # general use
    discord
    yubioath-flutter
    obsidian
    konversation
    libreoffice
    signal-desktop
    anki
    unstable.electron-mail
    zoom-us
    qbittorrent
    remmina
    idevicerestore
    libirecovery
    pandoc
    texlive.combined.scheme-full
    unstable.aseprite
    alsa-utils
    usbutils
    xclip
    firefox-nightly-bin
    zathura
    ripgrep-all

    # games
    prismlauncher
    mgba
    melonDS
    warp-randomizer
    unstable.r2modman
    fusee-interfacee-tk
    mcaselector

    # media
    obs-studio
    peek
    vlc
    audacity
    foliate

    # terminal
    fd
    sd
    du-dust
    unzip
    zip
    bottom

    # programming
    jetbrains-toolbox
    mongodb-compass
    gcc13
    rustup
    cargo-expand
    cargo-generate
    python312
    verilog
    logisim
    gnumake
    nodePackages.node2nix
    nixpkgs-fmt
    nil
    cmake
    racket
    sshfs
    bruno
    nmap
    wireshark
    xorg.xhost
    tcpdump
    heroku
    flyway
    bacon
    unityhub
    mono
    gh
    dotnet-sdk_8

    ldtk
    unstable.tracy

    # theme
    nordic
    papirus-icon-theme

    # admin
    arandr
    dconf-editor
  ] ++ (with python311Packages; [
    pip
    virtualenv
  ]);
}
