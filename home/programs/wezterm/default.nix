{
  programs.wezterm = {
    enable = true;

    extraConfig =
      # lua
      ''
        local wezterm = require "wezterm"

        local config = wezterm.config_builder()

        config.front_end = "WebGpu"

        config.font = wezterm.font("TT2020 Style E")
        config.line_height = 1.2

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
