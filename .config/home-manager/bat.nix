
{ pkgs, ... }:

{
  programs.bat = {
    enable = true;
    config = {
      # pager = "less -FR";
      # theme = "Dracula";
      # theme = "Nord";
      theme = "Solarized (light)";
      style = "plain";
    };
  };
}
