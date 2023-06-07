{ pkgs, ... }:

{
  home.sessionVariables = {
    NEOVIDE_MULTIGRID = "true";
  };

  home.packages = with pkgs; [
    neovide
    xclip # required for clipboard registers to work
    lazygit
    bacon
  ];

  programs.neovim = {
    enable = true;
    extraPackages = with pkgs; [
      rnix-lsp
    ];
  };

  xdg.configFile = {
    nvim = {
      source = pkgs.astronvim;
    };
    astronvim = {
      target = "astronvim/lua/user";
      source = ./astronvim-user-config;
    };
  };
}
