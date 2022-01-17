pkgs:

[
  {
    name = "open-terminal";
    binding = "<Super>Return";
    command = "${pkgs.gnome.gnome-terminal}/bin/gnome-terminal";
  }
  {
    name = "trigger-flameshot";
    binding = "<Super><Shift>s";
    command = "${pkgs.flameshot}/bin/flameshot gui";
  }
]