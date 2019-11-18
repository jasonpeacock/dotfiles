{ config, pkgs, ... }:

{
  imports = [
    ./fzf.nix
    ./git.nix
    ./neovim.nix
    ./ssh.nix
    ./zsh.nix
  ];

  home.packages = with pkgs; [
    #pandoc-sidenote
    #platformio
    asciinema
    bat
    curl
    elmPackages.elm
    entr
    exa
    exercism
    fd
    fswatch
    # https://github.com/NixOS/nixpkgs/tree/master/pkgs/applications/version-management/git-and-tools
    gitAndTools.git-extras
    gitAndTools.lefthook
    gitAndTools.tig
    html-tidy
    htop
    hyperfine
    gnupg
    jq
    pandoc
    plantuml
    python3
    reattach-to-user-namespace
    ripgrep
    shellcheck
    shfmt
    thefuck
    tmux
    travis
    tree
    watch
    wget
    yq
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
