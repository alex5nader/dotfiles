{ pkgs, ... }:

let
  keybinds = import ./keybinds.nix pkgs;
in

{
  imports = [
    <home-manager/nixos>
  ];

  users.users.noobstar = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.fish;
  };

  home-manager.users.noobstar = { lib, pkgs, ...}: with lib; {
    # packages
    home.packages = with pkgs; with jetbrains; [
      # general use
      firefox discord flameshot

      # programming
      idea-ultimate clion webstorm pycharm-professional

      # admin
      arandr gnome3.dconf-editor
    ];

    # shell
    programs.fish.enable = true;
    programs.starship = {
      enable = true;
      enableFishIntegration = true;
    };


    # dconf
    dconf.settings =
      with hm.gvariant;
      let
        toPath = keybind: "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/" + keybind.name;
        mkDef = keybind: { ${toPath keybind} = keybind; };
        paths = lib.lists.map (x: "/" + toPath x + "/") keybinds;
        settings = [
          (lists.foldr (x: y: x // y) {} (lists.forEach keybinds (keybind: {
            ${toPath keybind} = keybind;
          })))
          {
            "org/gnome/settings-daemon/plugins/media-keys" = {
              custom-keybindings = mkArray type.string paths;
            };
          }
        ];
      in
      lists.foldr lib.recursiveUpdate {} settings;
  };
}