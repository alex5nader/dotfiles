{ pkgs, ... }:

{
  programs.helix = {
    enable = true;
    settings = {
      editor = {
        line-number = "relative";
        bufferline = "multiple";
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
      };
      keys.normal = {
        "H" = ":buffer-previous";
        "L" = ":buffer-next";

        "space" = {
          "c" = ":buffer-close";
          "q" = ":quit";
          "w" = ":write";
        };
      };
    };
    languages = {
      language = [
        { name = "rust"; }
        { name = "nix"; }
      ];

      language-server.nil = {
        config = {
          nil.formatting.command = ["${pkgs.nixpkgs-fmt}/bin/nixpkgs-fmt"];
        };
      };

      language-server.tinymist = {
        config = {
          tinymist.preview.browsing.args = ["--data-plane-host=127.0.0.1:0" "--invert-colors=always" "--open"];
          # tinymist.preview.backround.enabled = true;
        };
      };
    };
  };
}
