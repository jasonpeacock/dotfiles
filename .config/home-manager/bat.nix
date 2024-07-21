{pkgs, ...}: {
  programs.bat = {
    enable = true;
    config = {
      # pager = "less -FR";
      theme = "Solarized (dark)";
      style = "plain";
    };
  };
}
