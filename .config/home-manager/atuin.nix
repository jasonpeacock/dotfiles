{ pkgs, ... }:

{
  programs.atuin = {
    enable = true;
    enableFishIntegration = true;
    # https://docs.atuin.sh/configuration/config/
    settings = {
        auto_sync = false;
        workspaces = true;
        enter_accept = true;
        filter_mode = "session";
    };
  };
}
