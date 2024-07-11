{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      bbenoist.nix
      arrterian.nix-env-selector
      editorconfig.editorconfig
      ms-vscode.cpptools
      skyapps.fish-vscode
    ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "VerilogHDL";
        publisher = "mshr-h";
        version = "1.5.3";
        sha256 = "1har7q0flqnx5q74nj3gn8l80aibmnn4xyscddbim5i5yqdx45g0";
      }
      {
        name = "language-koka";
        publisher = "koka";
        version = "2.0.4";
        sha256 = "yv4Na4fWEiTvLYBqCdIpZ8V08jv72JOcMKbf932wUfg=";
      }
    ];
  };
}
