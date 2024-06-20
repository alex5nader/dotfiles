{ config, lib, ... }:

let
  inherit (lib.attrsets) getBin;
  zellij = config.programs.zellij.package;
in

{
  programs.wezterm = {
    enable = true;

    extraConfig =
      # lua
      ''
        local wezterm = require "wezterm"

        local config = wezterm.config_builder()

        config.default_prog = { "${getBin zellij}/bin/zellij" }
        config.skip_close_confirmation_for_processes_named = { "zellij" }

        config.color_scheme = "nord"
        config.font = wezterm.font("monospace")

        config.enable_tab_bar = false
        config.window_decorations = "RESIZE"
        config.window_padding = {
          left = 0,
          right = 0,
          top = 0,
          bottom = 0,
        }

        return config
      '';
  };
}
