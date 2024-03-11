
{ pkgs, ... }:

{
  programs.bat = {
    enable = true;
    config = {
      # pager = "less -FR";
      # theme = "Dracula";
      # theme = "Nord";
      theme = "Catppuccin Mocha";
      style = "plain";
    };
  };
}
