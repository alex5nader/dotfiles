{ pkgs, ... }:

{
  # note: before creating opam switch for coq,
  # must be in a nix shell with coq (and maybe coqide)
  # otherwise, conf-gmp will fail to compile
  # this also breaks after collecting garbage :)
  home.packages = with pkgs; [ opam ];

  programs.fish.interactiveShellInit = ''
    source /home/noobstar/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true
  '';
}
