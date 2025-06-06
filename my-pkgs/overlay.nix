self: super: {
  astronvim = super.callPackage ./astronvim {};
  # s3s = super.callPackage ./s3s {};
  # splatnet2statink = super.callPackage ./splatnet2statink {};
  stardrop = super.callPackage ./stardrop {};
  warp-randomizer = super.callPackage ./warp-randomizer {};
  netconf-client = super.python3Packages.callPackage ./netconf-client.nix {};
}
