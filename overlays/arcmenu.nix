self: super:

{
  gnomeExtensions = super.gnomeExtensions // {
    arcmenu-27 = super.gnomeExtensions.arcmenu.overrideAttrs (old: rec {
      version = "27";

      src = self.fetchFromGitLab {
        owner = "arcmenu";
        repo = "ArcMenu";
        rev = "v${version}";
        sha256 = "1jdpy4nkdpq2d7hx2y66q5bmbpdzqy787p5jaj5795snpvih16jz";
      };
    });
  };
}