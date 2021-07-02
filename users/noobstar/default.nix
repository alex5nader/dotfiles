{ pkgs, ... }:

let
  keybinds = import ./keybinds.nix pkgs;
in

{
  imports = [
    <home-manager/nixos>
  ];

  users.users.noobstar = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.fish;
  };

  home-manager.users.noobstar = { lib, pkgs, ...}: with lib; {
    imports = [
      ./dconf
      ./fish-functions
      # ./gnome-terminal.nix
    ];

    # packages
    home.packages = with pkgs; with jetbrains; [
      # general use
      firefox discord yubioath-desktop unstable.obsidian konversation libreoffice signal-desktop

      # games
      multimc

      # media
      flameshot obs-studio peek

      # terminal
      exa fd sd du-dust

      # programming
      idea-ultimate clion webstorm pycharm-professional
      gcc rustup python38

      # theme
      nordic-polar papirus-icon-theme

      # admin
      arandr gnome.dconf-editor
    ] ++ (with python38Packages; [
      pip virtualenv
    ]);

    # terminal
    programs.fish = {
      enable = true;
      shellAliases = {
        ls = "${pkgs.exa}/bin/exa";
      };
    };
    programs.starship = {
      enable = true;
      enableFishIntegration = true;
    };


    # editors
    programs.vscode = {
      enable = true;
      extensions = with pkgs.vscode-extensions; [
        bbenoist.Nix arrterian.nix-env-selector
        editorconfig.editorconfig
        ms-vscode.cpptools
      ];
    };


    # other preferences
    gtk.gtk3.bookmarks = [
      "file:///home/noobstar/Projects"
      "file:///home/noobstar/School"
    ];
  };


  # fonts
  fonts = {
    enableDefaultFonts = false;
    fonts = with pkgs; [
      # sans & serif
      ttf_bitstream_vera liberation_ttf
      # monospace
      fira-code
      (nerdfonts.override { fonts = [ "FiraCode" ]; })
      # cjk
      ipafont
      # emoji
      twemoji-color-font
    ];
    fontconfig = {
      defaultFonts = {
        emoji = [
          "Twitter Color Emoji"
          "IPAGothic"
        ];
        monospace = [
          "Fira Code"
          "IPAGothic"
        ];
        sansSerif = [
          "Bitstream Vera Sans"
          "IPAGothic"
        ];
        serif = [
          "Bitstream Vera Serif"
          "IPAGothic"
        ];
      };
    };
  };
}
