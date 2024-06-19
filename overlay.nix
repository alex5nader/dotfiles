{ nixpkgs-unstable }:

self: super: {
  fusee-interfacee-tk = super.fusee-interfacee-tk.overrideAttrs (old: {
    installPhase = old.installPhase + "\n" + ''
      cp memloader.bin $out/bin/memloader.bin
    '';
  });

  # https://discourse.nixos.org/t/disable-ssh-agent-from-gnome-keyring-on-gnome/28176/5
  gnome = super.gnome.overrideScope (gself: gsuper: {
    gnome-keyring = gsuper.gnome-keyring.overrideAttrs (oldAttrs: {
      configureFlags = oldAttrs.configureFlags or [] ++ [
        "--disable-ssh-agent"
      ];
    });
  });

  steam = super.steam.override {
    extraPkgs = pkgs: with pkgs; [ pango harfbuzz libthai ];
  };
  
  unstable = import nixpkgs-unstable {
    system = self.system;

    config.allowUnfree = true;
  };

  vscode-extensions = self.lib.recursiveUpdate super.vscode-extensions {
    arrterian.nix-env-selector = self.vscode-utils.buildVscodeMarketplaceExtension {
      mktplcRef = {
        name = "nix-env-selector";
        publisher = "arrterian";
        version = "1.0.7";
        sha256 = "0mralimyzhyp4x9q98x3ck64ifbjqdp8cxcami7clvdvkmf8hxhf";
      };
      meta = {
        license = self.lib.licenses.mit;
      };
    };
  };
}
