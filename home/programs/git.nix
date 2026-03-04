{
  programs.git = {
    enable = true;

    signing = {
      key = null;
      signByDefault = true;
    };

    settings = {
      user.email = "contact@alexhabi.ch";
      user.name = "Alex Habich";

      init.defaultBranch = "main";
      core.editor = "hx";
      push.autoSetupRemote = true;
      push.default = "current";
    };
  };

  programs.difftastic = {
    enable = true;
    git.enable = true;
  };
}
