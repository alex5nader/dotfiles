{
  outputs = { self }: {
    overlays = [
      (self: super: {
        astronvim = super.callPackage ./astronvim {};
      })

      (self: super: {
        budgie = self.lib.recurseIntoAttrs (super.callPackage ./budgie {});
      })

      (self: super: {
        s3s = super.callPackage ./s3s {};
      })

      (self: super: {
        splatnet2statink = super.callPackage ./splatnet2statink {};
      })

      (self: super: {
        steam = super.steam.override {
          extraPkgs = pkgs: with pkgs; [ pango harfbuzz libthai ];
        };
      })

      (self: super: {
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
      })

      (self: super: {
        warp-randomizer = super.callPackage ./warp-randomizer {};
      })
    ];
  };
}