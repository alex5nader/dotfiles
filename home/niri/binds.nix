{ config, ... }:

{
  programs.niri.settings.binds = with config.lib.niri.actions; {
    "Mod+Space".action = spawn "fuzzel";
    "Mod+Return".action = spawn "wezterm";

    "Mod+Shift+S".action.screenshot = {};

    "Mod+Shift+F".action = toggle-window-floating;

    "Alt+Tab".action = toggle-overview;
    "Mod+F11".action = fullscreen-window;

    "XF86AudioPlay".action = spawn "playerctl" "play-pause";

    "XF86AudioRaiseVolume" = { allow-when-locked = true; action = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1+"; };
    "XF86AudioLowerVolume" = { allow-when-locked = true; action = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1-"; };
    "XF86AudioMute" = { allow-when-locked = true; action = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle"; };
    "XF86AudioMicMute" = { allow-when-locked = true; action = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle"; };
  };
}

