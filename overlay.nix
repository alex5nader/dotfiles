{ nixpkgs-unstable }:

self: super: {
  steam = super.steam.override {
    extraPkgs = pkgs: with pkgs; [ pango harfbuzz libthai ];
  };
  
  unstable = nixpkgs-unstable.outputs.legacyPackages.${self.system};

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
