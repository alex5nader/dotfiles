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
      core.editor = "nano";
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
      skyapps.fish-vscode
    ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [{
      name = "VerilogHDL";
      publisher = "mshr-h";
      version = "1.5.3";
      sha256 = "1har7q0flqnx5q74nj3gn8l80aibmnn4xyscddbim5i5yqdx45g0";
    }];
  };

  home.packages = with pkgs; with jetbrains; [
    # general use
    discord yubioath-desktop obsidian konversation libreoffice
    signal-desktop teams anki unstable.electron-mail zoom-us
    qbittorrent teams remmina

    # games
    multimc mgba warp-randomizer

    # media
    obs-studio peek aseprite-unfree vlc

    # terminal
    fd sd du-dust unzip

    # programming
    idea-ultimate clion webstorm pycharm-professional
    datagrip mongodb-compass gcc rustup python38 verilog
    logisim gnumake

    # theme
    nordic papirus-icon-theme

    # admin
    arandr gnome.dconf-editor
  ] ++ (with python38Packages; [
    pip virtualenv
  ]);
}
