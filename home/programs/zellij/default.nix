{ config, ... }:

{
  programs.zellij = {
    enable = true;
    # Should set zellij as start command in terminal emulator
    # This prevents other instances of fish (in IDE, etc) from automatically starting Zellij
    enableFishIntegration = false;
  };

  xdg.configFile = {
    "zellij/layouts/rust.kdl".text =
      # kdl
      ''
        layout {
        	pane size=1 borderless=true {
        		plugin location="tab-bar"
        	}
        	pane split_direction="vertical" {
        		pane command="hx"
        		pane command="bacon" start_suspended=true
        	}
        	pane size=2 borderless=true {
        		plugin location="status-bar"
        	}
        }
      '';
    "zellij/layouts/config.kdl".text =
      # kdl
      ''
        layout {
          cwd "${config.home.homeDirectory}/Projects/system-config"
          pane size=1 borderless=true {
            plugin location="tab-bar"
          }
          pane split_direction="vertical"  {
            pane command="hx"
            pane
          }
          pane size=2 borderless=true {
            plugin location="status-bar"
          }
        }
      '';
  };
}
