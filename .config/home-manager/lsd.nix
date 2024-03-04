{ pkgs, ... }:

{
  programs.lsd = {
    enable = false;
    enableAliases = true;
  };
}
