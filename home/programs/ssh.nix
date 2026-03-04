let
  # old default that was removed for some reason so i have to put it here
  old-default-config = {
    forwardAgent = false;
    addKeysToAgent = "no";
    compression = false;
    serverAliveInterval = 0;
    serverAliveCountMax = 3;
    hashKnownHosts = false;
    userKnownHostsFile = "~/.ssh/known_hosts";
    controlMaster = "no";
    controlPath = "~/.ssh/master-%r@%n:%p";
    controlPersist = "no";
  };
in

{
  services.ssh-agent.enable = true;
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks."*" = old-default-config // {
      controlMaster = "auto";
      controlPath = "~/.ssh/control-socket_%r@%n:%p";
      controlPersist = "10m";
      extraOptions = {
        IPQoS = "none";
      };
    };
  };
}
