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
    #platformio
    asciinema
    #awscli
    cargo
    cmake
    cookiecutter
    curl
    docker
    docker-compose
    entr
    fd
    fswatch
    # https://github.com/NixOS/nixpkgs/tree/master/pkgs/applications/version-management/git-and-tools
    gitAndTools.git-extras
    gitAndTools.lefthook
    gitAndTools.tig
    gping
    htop
    hyperfine
    jq
    plantuml
    python37
    python37Packages.black
    python37Packages.flake8
    python37Packages.flake8-blind-except
    python37Packages.flake8-import-order
    python37Packages.jsonschema
    python37Packages.lxml
    python37Packages.mypy
    python37Packages.pep8-naming
    python37Packages.yapf
    pypi2nix
    ripgrep
    rsync
    ruby
    rust-analyzer
    rustfmt
    shellcheck
    shfmt
    thefuck
    tree
    vivid
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
