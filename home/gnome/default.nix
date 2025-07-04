{
  dconf.settings = {
    "com/solus-project/budgie-panel" = {
      # Fix yellow background on some panel elements
      # Also applies nord theme
      builtin-theme = true;
    };

    "org/buddiesofbudgie/budgie-desktop-view" = {
      # Disable desktop icons
      show = false;
    };

    "org/gnome/desktop/interface" = {
      # Disables annoying behaviour when moving mouse into corner of screen
      enable-hot-corners = false;
      icon-theme = "Papirus";
    };

    "org/gnome/desktop/sound" = {
      # Disable awful drip sound when an "error" occurs
      event-sounds = false;
    };

    "org/gnome/desktop/wm/keybindings" = {
      # Switch between "windows" rather than "applications"
      # "applications" means group by type of app, "windows" lets
      # you scroll through each window of an app you have open 
      switch-applications = [ ];
      switch-applications-backward = [ ];
      switch-windows = [ "<Alt>Tab" ];
      switch-windows-backward = [ "<Shift><Alt>Tab" ];

      # Switch between workspaces like alt-tab
      switch-to-workspace-left = [ "<Shift><Super>Tab" ];
      switch-to-workspace-right = [ "<Super>Tab" ];
    };

    "org/gnome/gnome-session" = {
      # Save session (windows and their placement) when exiting
      auto-save-session = true;
    };

    "org/gnome/mutter" = {
      # Disable very annoying behaviour when super-dragging
      # where some windows move with others
      attach-modal-dialogs = false;

      # Make workspaces include all monitors
      workspaces-only-on-primary = false;
    };

    "org/gnome/settings-daemon/plugins/power" = {
      # Disables light-sensitive brightness
      ambient-enabled = false;
    };
  };
}

