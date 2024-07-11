{
  programs.eza = {
    enable = true;
    enableFishIntegration = false; # I prefer abbreviations instead of aliases
  };
  programs.fish.shellAbbrs = {
    ls = "eza --git-ignore";
    la = "eza -a";
    ll = "eza -l";
    lla = "eza -lla";
    lt = "eza --tree";
  };
}
