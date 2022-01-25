{ pkgs, ... }:

{
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
    };
  };

  programs.home-manager.enable = true;

  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      bbenoist.nix
      arrterian.nix-env-selector
      editorconfig.editorconfig
      ms-vscode.cpptools
    ];
  };

  home.packages = with pkgs; with jetbrains; [
    # general use
    discord yubioath-desktop obsidian konversation libreoffice
    signal-desktop teams anki unstable.electron-mail zoom-us
    qbittorrent teams

    # games
    multimc mgba warp-randomizer

    # media
    obs-studio peek aseprite-unfree vlc

    # terminal
    fd sd du-dust unzip

    # programming
    idea-ultimate clion webstorm pycharm-professional
    datagrip mongodb-compass gcc rustup python38

    # theme
    nordic papirus-icon-theme

    # admin
    arandr gnome.dconf-editor
  ] ++ (with python38Packages; [
    pip virtualenv
  ]);
}