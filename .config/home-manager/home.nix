{pkgs, ...}: let
#  mach-nix =
#    import (
#      builtins.fetchGit {
#        url = "https://github.com/DavHau/mach-nix/";
#        ref = "refs/tags/3.5.0";
#      }
#    ) {
#      python = "python310";
#    };

#  python310Custom = mach-nix.mkPython {
#    requirements = ''
#      # MyPy
#      mypy
#      # Python LSP
#      pylsp-mypy
#      black
#      python-lsp-black
#      python-lsp-server
#      pylsp-rope
#      rope
#    '';
#    packagesExtra = [
#        (mach-nix.buildPythonPackage {
#            pname = "python-lsp-ruff";
#            version = "1.0.2";
#            src = "https://github.com/python-lsp/python-lsp-ruff/tarball/v1.0.2";
#        })
#    ];
#  };
in {
  imports = [
    ./atuin.nix
    ./bat.nix
    ./broot.nix
    ./direnv.nix
    ./fish.nix
    ./fzf.nix
    ./git.nix
    ./git-cliff.nix
    ./gnupg.nix
    ./lsd.nix
    ./neovim.nix
    ./ssh.nix
    ./starship.nix
    ./tmux.nix
  ];

  # These packages have lightweight config, not worth having
  # their own configuration files.
  programs.eza.enable = true;
  programs.htop.enable = true;
  programs.jq.enable = true;

  home.stateVersion = "22.11";
  home.username = builtins.getEnv "USER";
  home.homeDirectory = builtins.getEnv "HOME";

  home.packages = with pkgs;
    [
      #platformio
      broot
      cookiecutter
      curl
      docker
      docker-compose
      du-dust
      entr
      exercism
      fd
      fswatch
      git-remote-codecommit
      # https://github.com/NixOS/nixpkgs/tree/master/pkgs/applications/version-management/git-and-tools
      gitAndTools.git-extras
      gitAndTools.lefthook
      gitAndTools.tig
      glow
      gping
      graphviz
      hyperfine
      mise
      netcat-gnu
      plantuml
      procs
      # python310Custom
      python310
      ripgrep
      rsync
      socat
      vhs
      watch
      wget
      yq

      # Mostly used by Neovim (nvim), but used here so they are available at the
      # commandline if needed.
      shellcheck
      shfmt
      mypy
      black
      ruff

      # Prompt/shell-theme tools
      vivid
    ]
    ++ lib.optionals stdenv.isLinux [
      can-utils
      sysstat
      gping # fails to build on OSX
      checkmake # not available on Darwin
    ]
    ++ lib.optionals stdenv.isDarwin [
      reattach-to-user-namespace
    ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
