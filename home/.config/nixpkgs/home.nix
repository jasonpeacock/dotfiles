{ config, pkgs, ... }:

{
  imports = [
    ./bat.nix
    ./direnv.nix
    ./fzf.nix
    ./git.nix
    ./gnupg.nix
    ./lsd.nix
    ./neovim.nix
    ./ssh.nix
    ./tmux.nix
    ./zsh.nix
  ];

  home.packages = with pkgs; [
    #pandoc-sidenote
    #platformio
    asciinema
    curl
    elmPackages.elm
    entr
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
    jq
    pandoc
    plantuml
    python3
    ripgrep
    shellcheck
    shfmt
    thefuck
    travis
    tree
    watch
    wget
    yq
  ] ++ stdenv.lib.optionals stdenv.isLinux [
    sysstat
  ] ++ stdenv.lib.optionals stdenv.isDarwin [
    reattach-to-user-namespace
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
