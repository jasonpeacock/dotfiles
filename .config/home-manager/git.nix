{pkgs, ...}:
with import ./git/host.nix; {
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
      files = "diff-tree --name-only -r --no-commit-id";
    };
    extraConfig = pkgs.lib.mkMerge [
      {
        color = {
          ui = "auto";
        };
        core = {
          editor = "nvim";
          # This conflicts with `delta` diff highlighter.
          # pager = "bat --style=plain --theme 'Dracula'";
          # pager = "bat --style=plain --theme 'Nord'";
          # pager = "bat --style=plain --theme 'Solarized (light)'";
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
          # syntax-theme = "Nord";
          syntax-theme = "Solarized (light)";
        };
      }
      gitExtraConfig
    ];
  };
}
