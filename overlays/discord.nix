self: super:

{
  discord = super.discord.override {
    nss = super.nss_latest;
  };
}