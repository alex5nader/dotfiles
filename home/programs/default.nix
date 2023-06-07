{ pkgs, ... }:

{
  imports = [
    ./flameshot
    ./neovim

    ./splatnet2statink.nix
  ];


  programs.chromium = {
    enable = true;
    package = pkgs.ungoogled-chromium;
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.exa = {
    enable = true;
    enableAliases = true;
  };

  programs.firefox.enable = true;

  programs.git = {
    enable = true;

    signing = {
      key = null;
      signByDefault = true;
    };

    userEmail = "contact@alexhabi.ch";
    userName = "Alex Habich";

    extraConfig = {
      init.defaultBranch = "main";
      core.editor = "nano";
    };
  };

  programs.home-manager.enable = true;

  programs.nix-index = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      bbenoist.nix
      arrterian.nix-env-selector
      editorconfig.editorconfig
      ms-vscode.cpptools
      skyapps.fish-vscode
    ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "VerilogHDL";
        publisher = "mshr-h";
        version = "1.5.3";
        sha256 = "1har7q0flqnx5q74nj3gn8l80aibmnn4xyscddbim5i5yqdx45g0";
      }
      {
        name = "language-koka";
        publisher = "koka";
        version = "2.0.4";
        sha256 = "yv4Na4fWEiTvLYBqCdIpZ8V08jv72JOcMKbf932wUfg=";
      }
    ];
  };

  home.packages = with pkgs; with jetbrains; [
    # general use
    discord
    yubioath-flutter
    obsidian
    konversation
    libreoffice
    signal-desktop
    teams
    anki
    unstable.electron-mail
    zoom-us
    qbittorrent
    teams
    remmina
    idevicerestore
    libirecovery

    # games
    prismlauncher
    mgba
    warp-randomizer

    # media
    obs-studio
    peek
    vlc
    audacity

    # terminal
    fd
    sd
    du-dust
    unzip
    bottom

    # programming
    idea-ultimate
    clion
    webstorm
    pycharm-professional
    datagrip
    mongodb-compass
    gcc
    rustup
    python38
    verilog
    logisim
    gnumake
    nodePackages.node2nix

    ldtk
    unstable.tracy

    # theme
    nordic
    papirus-icon-theme

    # admin
    arandr
    gnome.dconf-editor
  ] ++ (with python38Packages; [
    pip
    virtualenv
  ]);
}
