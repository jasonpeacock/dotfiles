
{ pkgs, ... }:

{
  programs.bat = {
    enable = true;
    config = {
#      pager = "less -FR";
      theme = "Solarized (light)";
      style = "plain";
    };
  };
}
