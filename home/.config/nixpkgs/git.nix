{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    package = pkgs.gitAndTools.git;
    userName = "Jason Peacock";
    userEmail = "jason@jasonpeacock.com";
    ignores = [".DS_Store"];
    lfs.enable = true;
    aliases = {
      graph = "log --graph --oneline --all --decorate --topo-order";
    };
    extraConfig = {
      core = {
        editor = "nvim";
        pager = "bat --style=plain --theme TwoDark";
      };
      push = {
        followtags = true;
      };
      pull = {
        rebase = true;
      };
      rerere = {
        enabled = true;
      };
    };
  };
}
