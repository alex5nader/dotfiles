{ pkgs, ... }:

{
  # note: before creating opam switch for coq,
  # enter devShells.buildCoq: nix develop .#buildCoq
  # this also breaks after collecting garbage :)
  home.packages = with pkgs; [ opam ];

  programs.fish.interactiveShellInit = ''
    source /home/noobstar/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true
  '';
}
