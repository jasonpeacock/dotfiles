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
  nixvim = import (builtins.fetchGit {
    url = "https://github.com/nix-community/nixvim";
  });
in {
  imports = [
    nixvim.homeManagerModules.nixvim
    ./atuin.nix
    ./bat.nix
    ./broot.nix
    ./direnv.nix
    ./fish.nix
    ./fzf.nix
    ./git.nix
    # ./git-cliff.nix
    ./gnupg.nix
    ./lsd.nix
    ./nixvim.nix
    ./ssh.nix
    ./starship.nix
    ./tmux.nix
  ];

  # These packages have lightweight config, not worth having
  # their own configuration files.
  programs.eza.enable = true;
  programs.htop.enable = true;
  programs.jq.enable = true;
  programs.scmpuff = {
    enable = true;
    # Disable default Git aliases, we explicitly add `gs` in `fish.nix`.
    enableAliases = false;
  };

  # Lazy Git?

  home = {
    stateVersion = "24.05";
    username = builtins.getEnv "USER";
    homeDirectory = builtins.getEnv "HOME";
  };

  home.packages = with pkgs;
    [
      #platformio
      broot
      cookiecutter
      corretto21 # Java (OpenJDK) from Amazon: https://aws.amazon.com/corretto
      curl
      dive
      docker
      docker-compose
      du-dust
      entr
      eternal-terminal
      exercism
      fd
      fswatch
      git-extras
      git-filter-repo
      git-ps-rs # stacked commits
      git-stack # stacked commits
      git-spice # stacked commits
      gitlint
      glow
      gping
      graphviz
      hyperfine
      jless
      lazygit # TODO choose between this and `tig`
      lefthook
      mise
      netcat-gnu
      nodejs_22
      openssl.dev
      plantuml
      procs
      # python310Custom
      python310
      ripgrep
      rsync
      socat
      stgit # stacked commits
      tig # TODO choose between this and `lazygit`
      usage
      vhs
      watch
      wget
      yq

      # Mostly used by Neovim (nvim), but included here so they are available at the commandline if needed.
      alejandra # Nix - https://kamadorueda.com/alejandra/
      black # Python - https://black.readthedocs.io/en/stable/
      cmake-format # CMake - https://github.com/cheshirekow/cmake_format
      codespell # Spelling - https://github.com/codespell-project/codespell
      eslint_d # JS/TS/JSON - https://github.com/mantoni/eslint_d.js/
      isort # Python - https://pycqa.github.io/isort/
      jdt-language-server # `jdtls`: https://github.com/eclipse-jdtls/eclipse.jdt.ls
      markdownlint-cli2 #Markdown - https://github.com/DavidAnson/markdownlint-cli2
      marksman # Markdown - https://github.com/artempyanykh/marksman
      mypy # Python - https://www.mypy-lang.org/
      nil # Nix - https://github.com/oxalica/nil
      ruff # Python - https://github.com/astral-sh/ruff
      shellcheck # Bash - https://github.com/koalaman/shellcheck
      shfmt # Bash - https://github.com/mvdan/sh
      stylua # Lua - https://github.com/JohnnyMorganz/StyLua
      vscode-langservers-extracted # JS/TS/JSON https://github.com/hrsh7th/vscode-langservers-extracted

      # Prompt/shell-theme tools
      vivid
    ]
    ++ lib.optionals stdenv.isLinux [
      can-utils
      sysstat
      checkmake # not available on Darwin
    ]
    ++ lib.optionals stdenv.isDarwin [
      reattach-to-user-namespace
    ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
