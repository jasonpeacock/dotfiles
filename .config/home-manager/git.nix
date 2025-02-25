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
        dark = true;
        # Not sure why this isn't working - the terminal really is true color,
        # but it's showing too dark when rendered via Git.
        true-color = "never";
        line-numbers = true;
        syntax-theme = "gruvbox-dark";
      };
    };
    # https://difftastic.wilfred.me.uk/
    difftastic = {
      enable = true;
      background = "dark"; # light dark
      display = "side-by-side-show-both"; # side-by-side side-by-side-show-both inline
    };
    aliases = {
      graph = "log --graph --oneline --all --decorate --topo-order";
      dag = "log --graph --format='format:%C(yellow)%h%C(reset) %C(blue)\"%an\" <%ae>%C(reset) %C(magenta)%cr%C(reset)%C(auto)%d%C(reset)%n%s' --date-order";
      files = "diff-tree --name-status -r --no-commit-id";
    };
    # https://jvns.ca/blog/2024/02/16/popular-git-config-options/
    # https://blog.gitbutler.com/how-git-core-devs-configure-git/
    extraConfig = pkgs.lib.mkMerge [
      {
        branch = {
          sort = "-committerdate";
        };
        column = {
          ui = "auto";
        };
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
          pager = "bat --style=plain --theme 'gruvbox-dark'";
        };
        diff = {
          algorithm = "histogram";
          colorMoved = true;
          mnemonicPrefix = true;
          renames = true;
        };
        help = {
          autocorrect = "prompt";
        };
        fetch = {
          all = true;
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
          autoSetupRemote = true;
          followtags = true;
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
          autoupdate = true;
          enabled = true;
        };
        tag = {
          sort = "version:refname";
        };
      }
      gitExtraConfig
    ];
  };
}
