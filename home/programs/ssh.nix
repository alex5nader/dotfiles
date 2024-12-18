{
  services.ssh-agent.enable = true;
  programs.ssh = {
    enable = true;
    controlMaster = "auto";
    controlPath = "~/.ssh/control-socket_%r@%n:%p";
    controlPersist = "10m";
    matchBlocks = {
      cs1 = {
        hostname = "cs1.utdallas.edu";
        user = "ash190005";
      };
      cs2 = {
        hostname = "cs2.utdallas.edu";
        user = "ash190005";
      };
      opnear3 = {
        hostname = "10.177.46.94";
        user = "opnear3";
      };
      opnear4 = {
        hostname = "10.177.46.143";
        user = "opnear4";
      };
      mininet = {
        hostname = "localhost";
        port = 8022;
        user = "mininet";
        forwardX11 = true;
        forwardAgent = true;
      };
      "opnear-gitlab" = {
        hostname = "localhost";
        port = 8122;
      };
    };
    extraConfig = ''
      IPQoS=none
    '';
  };

  programs.fish.shellAbbrs = {
    forward-openlab = "ssh -L 8122:10.177.47.43:22 -L 8123:10.177.47.43:80 ash190005@10.177.47.85 -fN";
  };
}
