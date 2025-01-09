{
  programs.bacon.enable = true;
  programs.bacon.settings = {
    jobs.build = {
      command = ["cargo" "build"];
    };
    keybindings."ctrl-b" = "job:build";
  };
}
