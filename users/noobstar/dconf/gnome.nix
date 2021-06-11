{ ... }:

{
  "org/gnome/desktop/interface" = {
    # Disables annoying behaviour when moving mouse into corner of screen
    enable-hot-corners = false;

    # Theming
    gtk-theme = "Nordic-Polar";
  };

  "org/gnome/desktop/wm/keybindings" = {
    # Switch between "windows" rather than "applications"
    # "applications" means group by type of app, "windows" lets
    # you scroll through each window of an app you have open 
    switch-applications = [];
    switch-applications-backward = [];
    switch-windows = [ "<Alt>Tab" ];
    switch-windows-backward = [ "<Shift><Alt>Tab" ];
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
}