{ pkgs, lib, ... }:

let
  extensions = import ./extensions.nix pkgs;
in

{
  imports = [
    ./terminal.nix
  ];

  home.packages = extensions;

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      # Disables annoying behaviour when moving mouse into corner of screen
      enable-hot-corners = false;

      # Theming
      gtk-theme = "Nordic-Polar";
      monospace-font-name = "FiraCode Nerd Font 10";
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

    "org/gnome/shell" = {
      # Enable extensions installed via environment.systemPackages
      disable-user-extensions = false;
      enabled-extensions =
        let
          inherit (lib.lists) map;
          getUuid = extension:
            if extension ? uuid
            then extension.uuid
            else if extension.passthru ? extensionUuid
            then extension.passthru.extensionUuid
            else throw "Extension ${extension} does not have .uuid or .passthru.extensionUuid";
        in
        map getUuid extensions;
    };

    "org/gnome/shell/extensions/user-theme" = {
      name = "Nordic-Polar";
    };
  };
}

