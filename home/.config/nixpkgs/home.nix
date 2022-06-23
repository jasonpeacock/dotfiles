{ config, pkgs, ... }:

let
  mach-nix = import (
    builtins.fetchGit {
      url = "https://github.com/DavHau/mach-nix/";
      ref = "refs/tags/2.0.0";
    }
  );

  python39Custom = mach-nix.mkPython {
    python = pkgs.python39;
    requirements = ''
      pycapnp
      pyyaml
    '';
  };
in

{
  imports = [
    ./atuin.nix
    ./bat.nix
    ./direnv.nix
    ./fish.nix
    ./fzf.nix
    ./git.nix
    ./gnupg.nix
    ./lsd.nix
    ./neovim.nix
    ./ssh.nix
    ./tmux.nix
  ];

  # These packages have lightweight config, not worth having
  # their own configuration files.
  programs.exa.enable = true;
  programs.htop.enable = true;
  programs.jq.enable = true;

  home.stateVersion = "22.11";
  home.username = builtins.getEnv "USER";
  home.homeDirectory = builtins.getEnv "HOME";

  home.packages = with pkgs; [
    #platformio
    asciinema
    cmake
    cookiecutter
    curl
    docker
    docker-compose
    entr
    exercism
    fd
    fswatch
    # https://github.com/NixOS/nixpkgs/tree/master/pkgs/applications/version-management/git-and-tools
    gitAndTools.git-extras
    gitAndTools.lefthook
    gitAndTools.tig
    git-remote-codecommit
    glow
    gping
    hyperfine
    netcat-gnu
    plantuml
    poetry
    python39Custom
    ripgrep
    rsync
    ruby
    socat
    thefuck
    watch
    wget
    yq

    # Prompt/shell-theme tools
    starship
    vivid

    # Formatters/linters
    alejandra
    buf
    checkmake
    cppcheck
    deadnix
    gitlint
    hadolint
    nixfmt
    nodePackages.alex
    nodePackages.eslint_d
    nodePackages.jsonlint
    nodePackages.markdownlint-cli
    proselint
    python39Packages.black
    python39Packages.codespell
    python39Packages.flake8
    python39Packages.flake8-blind-except
    python39Packages.flake8-docstrings
    python39Packages.flake8-import-order
    python39Packages.jsonschema
    python39Packages.lxml
    python39Packages.mypy
    python39Packages.pep8-naming
    python39Packages.pydocstyle
    python39Packages.vulture
    python39Packages.yamllint
    python39Packages.yapf
    rubocop
    rust-analyzer
    rustfmt
    selene
    shellcheck
    shellharden
    shfmt
    statix
    html-tidy
  ] ++ lib.optionals stdenv.isLinux [
    can-utils
    sysstat
    gping # fails to build on OSX
  ] ++ lib.optionals stdenv.isDarwin [
    reattach-to-user-namespace
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
