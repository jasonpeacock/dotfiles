{ config, pkgs, ... }:

{
  home.packages = [
    #pkgs.pandoc-sidenote
    #pkgs.platformio
    pkgs.asciinema
    pkgs.bat
    pkgs.curl
    pkgs.elmPackages.elm
    pkgs.entr
    pkgs.exa
    pkgs.exercism
    pkgs.fd
    pkgs.fswatch
    # https://github.com/NixOS/nixpkgs/tree/master/pkgs/applications/version-management/git-and-tools
    #pkgs.gitAndTools.git-big-picture
    pkgs.gitAndTools.git-extras
    pkgs.gitAndTools.lefthook
    pkgs.gitAndTools.tig
    pkgs.html-tidy
    pkgs.htop
    pkgs.hyperfine
    pkgs.jq
    pkgs.neovim
    pkgs.pandoc
    pkgs.plantuml
    pkgs.python3
    pkgs.reattach-to-user-namespace
    pkgs.ripgrep
    pkgs.shellcheck
    pkgs.shfmt
    pkgs.thefuck
    pkgs.tmux
    pkgs.travis
    pkgs.tree
    pkgs.watch
    pkgs.wget
    pkgs.yq
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    package = pkgs.gitAndTools.git;
    userName = "Jason Peacock";
    userEmail = "jason@jasonpeacock.com";
    ignores = [".DS_Store"];
    lfs.enable = true;
    extraConfig = {
      core = {
        editor = "nvim";
        pager = "bat --style=plain --theme TwoDark";
      };
      push = {
        followtags = true;
      };
    };
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    changeDirWidgetCommand = "fd --type d";
    changeDirWidgetOptions = [ "--preview 'tree -C {} | head -200'" ];
    defaultCommand = "fd --type f";
    defaultOptions = [ "--height 40%" "--border" ];
    fileWidgetCommand = "fd --type f";
    fileWidgetOptions = [ "--preview 'head {}'" ];
    historyWidgetOptions = [ "--sort" "--exact" ];
  };

  programs.zsh = {
    enable = true;
    autocd = false;
    defaultKeymap = "emacs";
    dotDir = ".config/zsh";
    enableAutosuggestions = true;
    enableCompletion = true;
    history = {
      expireDuplicatesFirst = true;
      extended = false;
      ignoreDups = true;
      save = 10000;
      path = ".zsh_history";
      share = true;
    };
    oh-my-zsh = {
      enable = true;
      plugins = [
        "aws"
        "cargo"
        "catimg"
        "colored-man-pages"
        "docker"
        "docker-compose"
        "fd"
        "git"
        "git-extras"
        "jira"
        "python"
        "ripgrep"
        "rust"
        "tig"
        "tmux"
        "thefuck"
      ];
    };
    sessionVariables = {};
    # .zshenv
    envExtra = "
export PAGER=\"bat --style=plain --theme TwoDark\"
    ";
    # .zshrc
    initExtra = "
source \"$HOME/.config/powerlevel10k/powerlevel10k.zsh-theme\"
    ";
    initExtraBeforeCompInit = "
source \"$HOME/.nix-profile/etc/profile.d/nix.sh\"

#
# Load host-specific configuration.
#
THIS_HOST=`hostname | sed 's/\\..*$//'`
if [ -f $HOME/.zsh/$THIS_HOST.zshrc ] ; then
    . $HOME/.zsh/$THIS_HOST.zshrc
    export PATH=\"$PATH:$HOME/.$THIS_HOST-bin\"
else
    echo \"*** No host-specific file found! Expected [$HOME/.zsh/$THIS_BOX.zshrc] ***\"
fi

#
# Dotfile management with homeshick.
#
source \"$HOME/.homesick/repos/homeshick/homeshick.sh\"
fpath=($HOME/.homesick/repos/homeshick/completions $fpath)
# Check everything is up-to-date.
homeshick --quiet refresh
    ";
    # .zlogin
    loginExtra = "";
    # .zlogout
    logoutExtra = "";
    # .zprofile
    profileExtra = "";
    # .zshrc
    localVariables = {
      # Customize the Powerlevel9k theme.
      # https://github.com/bhilburn/powerlevel9k
      POWERLEVEL9K_PROMPT_ADD_NEWLINE=true;
      POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=["status" "context_joined"];
      POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=["dir" "vcs" "command_execution_time"];
      # Default 'context' is "%n@%m", drop the username (%n) and always show it.
      POWERLEVEL9K_ALWAYS_SHOW_CONTEXT=true;
      POWERLEVEL9K_CONTEXT_TEMPLATE="\${HOST_NICKNAME:-%m}";
      # Shorten the 'dir'.
      POWERLEVEL9K_SHORTEN_DIR_LENGTH=3;
      POWERLEVEL9K_SHORTEN_DELIMITER="..";
      # Drop the return code from 'status' and always show it.
      POWERLEVEL9K_STATUS_VERBOSE=false;
      POWERLEVEL9K_STATUS_OK_IN_NON_VERBOSE=true;
      # Use the awesome version of SourceCodePro font.
      #POWERLEVEL9K_MODE='awesome-patched'
      # Remove the extraneous Git icons (it's always Git).
      POWERLEVEL9K_VCS_GIT_ICON="";
      POWERLEVEL9K_VCS_GIT_GITHUB_ICON="";
      # Remove the duration icon, keep things compact.
      POWERLEVEL9K_EXECUTION_TIME_ICON="";
      # Remove the folder icons, keep things compact.
      POWERLEVEL9K_FOLDER_ICON="";
      POWERLEVEL9K_HOME_ICON="";
      POWERLEVEL9K_HOME_SUB_ICON="";

      # Customize zsh-autosuggestion
      # 10 = dark grey
      ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=10";

      # Configure OhMyZsh `tmux` plugin.
      # https://github.com/robbyrussell/oh-my-zsh/wiki/Plugins#tmux
      ZSH_TMUX_AUTOSTART=false;
      ZSH_TMUX_AUTOSTART_ONCE=true;
      ZSH_TMUX_AUTOCONNECT=true;
      ZSH_TMUX_AUTOQUIT=false;
      ZSH_TMUX_FIXTERM=true;
      ZSH_TMUX_FIXTERM_WITH_256COLOR="screen-256color";
      ZSH_TMUX_FIXTERM_WITHOUT_256COLOR="screen";
    };
    shellAliases = {
      bc="bc -l -q \"\$HOME/.bc\"";
      checkpoint="git status && git add -A && git commit -m \"checkpoint\" --no-verify";
      grep="grep --color=auto";
      less="less -R -n";
      scp="scp -C";
      tbase="tmux attach -t base || tmux new -s base";
      vi="nvim -o";
      work="cd \"$HOME/workplace\"";
      http="python3 -m http.server";
      tree="tree -C";
      black="black -l 120";
      bat="bat --style plain --theme TwoDark";
    };
    plugins = [
      {
        name = "enhancd";
        file = "init.sh";
        src = pkgs.fetchFromGitHub {
          owner = "b4b4r07";
          repo = "enhancd";
          rev = "v2.2.4";
          sha256 = "1smskx9vkx78yhwspjq2c5r5swh9fc5xxa40ib4753f00wk4dwpp";
        };
      }
      {
        name = "zsh-syntax-highlighting";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-syntax-highlighting";
          rev = "v0.6.0";
          sha256 = "0zmq66dzasmr5pwribyh4kbkk23jxbpdw4rjxx0i7dx8jjp2lzl4";
        };
      }
    ];
  };

}
