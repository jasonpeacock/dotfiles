{ config, pkgs, ... }:

let
  mach-nix = import (
    builtins.fetchGit {
      url = "https://github.com/DavHau/mach-nix/";
      ref = "2.0.0";
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
    git-remote-codecommit
    gping
    htop
    hyperfine
    influxdb
    jq
    plantuml
    poetry
    python39Custom
    python39Packages.black
    python39Packages.flake8
    python39Packages.flake8-blind-except
    python39Packages.flake8-import-order
    python39Packages.jsonschema
    python39Packages.lxml
    python39Packages.mypy
    python39Packages.pep8-naming
    python39Packages.yapf
    ripgrep
    rsync
    ruby
    rustc
    rust-analyzer
    rustfmt
    shellcheck
    shfmt
    srecord
    starship
    tree
    vivid
    watch
    wget
    yq
  ] ++ lib.optionals stdenv.isLinux [
    can-utils
    sysstat
  ] ++ lib.optionals stdenv.isDarwin [
    reattach-to-user-namespace
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
