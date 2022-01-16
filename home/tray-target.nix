# Fixes issue with flameshot -- see https://github.com/nix-community/home-manager/issues/2064

{
  systemd.user.targets.tray = {
		Unit = {
			Description = "Home Manager System Tray";
			Requires = [ "graphical-session-pre.target" ];
		};
	};
}