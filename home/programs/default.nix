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
    remmina
    sweethome3d.application
    bitwarden-desktop
    pinta
    xsel
    jq
    krita
    typst
    tinymist

    # games
    prismlauncher
    mgba
    melonDS
    warp-randomizer
    unstable.r2modman
    fusee-interfacee-tk
    mcaselector
    icu # needed for stardew valley modding
    stardrop
    gamescope
    protontricks

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

    # admin
    arandr
    dconf-editor
  ] ++ (with python311Packages; [
    pip
    virtualenv
  ]);
}
