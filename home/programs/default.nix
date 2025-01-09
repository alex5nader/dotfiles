{ pkgs, ... }:

{
  imports = [
    ./flameshot
    ./warp
    ./wezterm
    ./zellij

    ./bacon.nix
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
    libreoffice
    zoom-us
    qbittorrent
    pandoc
    texlive.combined.scheme-full
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
    gcc13
    rustup
    cargo-expand
    cargo-generate
    python312
    gnumake
    nixpkgs-fmt
    nil
    cmake
    sshfs
    bruno
    nmap
    gh
    renderdoc

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
