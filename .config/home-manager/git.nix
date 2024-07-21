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
    delta = {
      enable = false;
      options = {
        dark = false;
        # Not sure why this isn't working - the terminal really is true color,
        # but it's showing too dark when rendered via Git.
        true-color = "never";
        line-numbers = true;
        syntax-theme = "Solarized (dark)";
      };
    };
    # https://difftastic.wilfred.me.uk/
    difftastic = {
      enable = true;
      background = "light"; # light dark
      color = "auto"; # always auto never
      display = "side-by-side-show-both"; # side-by-side side-by-side-show-both inline
    };
    aliases = {
      graph = "log --graph --oneline --all --decorate --topo-order";
      dag = "log --graph --format='format:%C(yellow)%h%C(reset) %C(blue)\"%an\" <%ae>%C(reset) %C(magenta)%cr%C(reset)%C(auto)%d%C(reset)%n%s' --date-order";
      files = "diff-tree --name-status -r --no-commit-id";
    };
    # https://jvns.ca/blog/2024/02/16/popular-git-config-options/
    extraConfig = pkgs.lib.mkMerge [
      {
        color = {
          ui = "auto";
        };
        commit = {
          # Show diff in the commit. This sounds good, but for large commits such as deleting
          # lots of files, it causes `git commit` to hang while the massive diff is generated.
          verbose = false;
        };
        core = {
          editor = "nvim";
          # This conflicts with `delta` diff highlighter.
          pager = "bat --style=plain --theme 'Solarized (dark)'";
        };
        help = {
          autocorrect = 10;
        };
        fetch = {
          prune = true;
          prunetags = true;
        };
        log = {
          date = "iso";
        };
        merge = {
          conflictstyle = "zdiff3";
        };
        push = {
          followtags = true;
          default = "simple";
        };
        pull = {
          rebase = true;
        };
        rebase = {
          autosquash = true;
          autostash = true;
          updateRefs = true;
          missingCommitsCheck = "error";
        };
        rerere = {
          enabled = true;
        };
      }
      gitExtraConfig
    ];
  };
}
