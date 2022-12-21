{ pkgs, ... }:

{
  home.sessionVariables = {
    NEOVIDE_MULTIGRID = "1";
  };

  home.packages = with pkgs; [
    neovim-unwrapped neovide
    xclip # required for clipboard registers to work
    lazygit
    rust-analyzer bacon
  ];

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
