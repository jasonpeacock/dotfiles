{ pkgs, ... }:

{
  programs.atuin = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      autosync = false;
      search_mode = "fuzzy";
    };
  };
}
