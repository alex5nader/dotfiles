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
    # packages
    home.packages = with pkgs; with jetbrains; [
      # general use
      firefox discord flameshot obs-studio peek

      # terminal
      exa fd sd du-dust

      # programming
      idea-ultimate clion webstorm pycharm-professional

      # admin
      arandr gnome3.dconf-editor
    ];

    # terminal
    programs.fish = {
      enable = true;
      functions = import ./fish-functions.nix;
      shellAliases = {
        ls = "${pkgs.exa}/bin/exa";
      };
    };
    programs.starship = {
      enable = true;
      enableFishIntegration = true;
    };


    # dconf
    dconf.settings =
      let
        settings = [
          (import ./keybinds.nix { inherit pkgs lib; })
        ];
      in
      lists.foldr lib.recursiveUpdate {} settings;


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
          "Fira Code Retina"
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
