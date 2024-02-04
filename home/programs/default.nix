{ pkgs, ... }:

{
  imports = [
    ./flameshot
    ./neovim

    # ./splatnet2statink.nix
  ];


  programs.chromium = {
    enable = true;
    package = pkgs.ungoogled-chromium;
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.eza = {
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

  programs.helix = {
    enable = true;
    settings = {
      theme = "nord";
      editor = {
        line-number = "relative";
        bufferline = "multiple";
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
      };
      keys.normal = {
        "H" = ":buffer-previous";
        "L" = ":buffer-next";

        "space" = {
          "c" = ":buffer-close";
          "q" = ":quit";
          "w" = ":write";
        };
      };
    };
    languages = {
      language = [
        { name = "rust"; }
        { name = "nix"; }
      ];

      language-server.nil = {
        config = {
          nil.formatting.command = ["${pkgs.nixpkgs-fmt}/bin/nixpkgs-fmt"];
        };
      };
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

    # games
    prismlauncher
    mgba
    warp-randomizer
    unstable.r2modman

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
    jetbrains-toolbox
    datagrip
    mongodb-compass
    gcc13
    rustup
    python311
    verilog
    logisim
    gnumake
    nodePackages.node2nix
    nixpkgs-fmt
    nil
    cmake
    racket

    ldtk
    unstable.tracy

    # theme
    nordic
    papirus-icon-theme

    # admin
    arandr
    gnome.dconf-editor
  ] ++ (with python311Packages; [
    pip
    virtualenv
  ]);
}
