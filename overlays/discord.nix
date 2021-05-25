self: super:

{
  discord = super.discord.override rec {
    version = "0.0.15";
    src = super.fetchurl {
      url = "https://dl.discordapp.net/apps/linux/${version}/discord-${version}.tar.gz";
      sha256 = "0pn2qczim79hqk2limgh88fsn93sa8wvana74mpdk5n6x5afkvdd";
    };
    nss = super.nss_latest;
  };
}