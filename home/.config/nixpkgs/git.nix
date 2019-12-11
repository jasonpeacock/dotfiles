{ pkgs, ... }:

with import ./git/host.nix;

{
  programs.git = {
    enable = true;
    package = pkgs.gitAndTools.git;
    userName = gitUserName;
    userEmail = gitUserEmail;
    ignores = [".DS_Store"];
    lfs.enable = true;
    aliases = {
      graph = "log --graph --oneline --all --decorate --topo-order";
      dag = "log --graph --format='format:%C(yellow)%h%C(reset) %C(blue)\"%an\" <%ae>%C(reset) %C(magenta)%cr%C(reset)%C(auto)%d%C(reset)%n%s' --date-order";
    };
    extraConfig = {
      color = {
        ui = "auto";
      };
      core = {
        editor = "nvim";
        pager = "bat --style=plain --theme TwoDark";
      };
      push = {
        followtags = true;
        default = "simple";
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
