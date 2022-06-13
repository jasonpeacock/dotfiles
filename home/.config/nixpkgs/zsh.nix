{ pkgs, ... }:

{
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
        "catimg"
        "colored-man-pages"
        "docker"
        "docker-compose"
        "fd"
        "git"
        "git-extras"
        "python"
        "ripgrep"
        "rust"
        "tig"
        "tmux"
      ];
    };
    sessionVariables = {};
    # .zshenv
    envExtra = "";
    # .zshrc
    initExtra = "
eval \"$(starship init zsh)\"

nixify() {
  if [ ! -e ./.envrc ]; then
    echo \"use nix\" > .envrc
    ${pkgs.direnv}/bin/direnv allow
  fi
  if [ ! -e default.nix ]; then
    cat > default.nix <<'EOF'
with import <nixpkgs> {};
stdenv.mkDerivation {
  name = \"env\";
  buildInputs = [
    bashInteractive
  ];
}
EOF
    \${EDITOR:-nvim} default.nix
  fi
}
    ";
    initExtraBeforeCompInit = "
source \"$HOME/.nix-profile/etc/profile.d/nix.sh\"

#
# Load host-specific configuration.
#
THIS_HOST=`hostname | sed 's/\\..*$//'`
if [ -f $HOME/.zsh/$THIS_HOST.zshrc ] ; then
    . $HOME/.zsh/$THIS_HOST.zshrc
    export PATH=\"$PATH:$HOME/.$THIS_HOST-bin:$HOME/.cargo/bin\"
else
    echo \"*** No host-specific file found! Expected [$HOME/.zsh/$THIS_BOX.zshrc] ***\"
fi

#
# Dotfile management with homeshick.
#
source \"$HOME/.homesick/repos/homeshick/homeshick.sh\"
fpath=($HOME/.homesick/repos/homeshick/completions $fpath)
# Check everything is up-to-date.
# TODO stop checking, it slows down the initial terminal
# launching. Do something smarter - wrap it in a weekly
# check against a timestamp file?
# homeshick --quiet refresh

export LS_COLORS=\"$(vivid generate solarized-light)\"

# Custom Zsh completions
fpath=($HOME/.zsh/completions $fpath)
    ";
    # .zlogin
    loginExtra = "";
    # .zlogout
    logoutExtra = "";
    # .zprofile
    profileExtra = "";
    # .zshrc
    localVariables = {
      # Customize zsh-autosuggestion
      # 10 = dark grey
      # ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=10";

      # Configure OhMyZsh `tmux` plugin.
      # https://github.com/robbyrussell/oh-my-zsh/wiki/Plugins#tmux
      ZSH_TMUX_AUTOSTART=false;
      ZSH_TMUX_AUTOSTART_ONCE=true;
      ZSH_TMUX_AUTOCONNECT=true;
      ZSH_TMUX_AUTOQUIT=false;
      ZSH_TMUX_FIXTERM=true;
      ZSH_TMUX_FIXTERM_WITH_256COLOR="screen-256color";
      ZSH_TMUX_FIXTERM_WITHOUT_256COLOR="screen";

      EDITOR="nvim";
    };
    shellAliases = {
      bc="bc -l -q \"\$HOME/.bc\"";
      sync="git checkout mainline && git fetch --prune && git pull";
      checkpoint="git status && git add -A && git commit -m \"checkpoint\" --no-verify";
      grep="grep --color=auto";
      less="less -R -n";
      scp="scp -C";
      vi="nvim -o";
      work="cd \"$HOME/workplace\"";
      http="python3 -m http.server";
      tree="exa --tree --icons --git";
      ls="exa --icons --git";
    };
    plugins = [
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
