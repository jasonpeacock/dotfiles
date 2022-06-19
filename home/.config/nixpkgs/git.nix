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
    # https://github.com/dandavison/delta
    delta.enable = true;
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
        # This conflicts with `delta` diff highlighter.
        # pager = "bat --style=plain --theme 'Dracula'";
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
      delta = {
        dark = true;
        # Not sure why this isn't working - the terminal really is true color,
        # but it's showing too dark when rendered via Git.
        true-color = "never";
        line-numbers = true;
        syntax-theme = "Dracula";
      };
    };
  };
}
