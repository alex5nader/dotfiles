{
  programs.git = {
    enable = true;

    signing = {
      key = null;
      signByDefault = true;
    };

    userEmail = "contact@alexhabi.ch";
    userName = "Alex Habich";

    extraConfig = {
      init.defaultBranch = "main";
      core.editor = "nano";
      push.autoSetupRemote = true;
      push.default = "current";
    };

    difftastic.enable = true;
  };
}
