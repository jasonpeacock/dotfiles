{pkgs, ...}: let
  mach-nix =
    import (
      builtins.fetchGit {
        url = "https://github.com/DavHau/mach-nix/";
        ref = "refs/tags/3.5.0";
      }
    ) {
      python = "python39";
    };

  python39Custom = mach-nix.mkPython {
    requirements = ''
      awscliv2
      boto3
      botocore
      git-remote-codecommit
      invoke
      requests
      # C-based packages
      pycapnp
      pyyaml
      # Flake8 & Plugins
      flake8
      flake8-import-order
      flake8-docstrings
      flake8-blind-except
      flake8-builtins
      pep8-naming
      pydocstyle
      # MyPy
      mypy
      types-PyYAML
      # Python LSP
      pylsp-mypy
      black
      python-lsp-black
      python-lsp-server
      #python-lsp-ruff
      rope
    '';
    packagesExtra = [
        (mach-nix.buildPythonPackage {
            pname = "python-lsp-ruff";
            version = "1.0.2";
            src = "https://github.com/python-lsp/python-lsp-ruff/tarball/v1.0.2";
        })
    ];
  };
in {
  imports = [
    ./atuin.nix
    ./bat.nix
    ./broot.nix
    ./direnv.nix
    ./fish.nix
    ./fzf.nix
    ./git.nix
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
      asdf-vm
      broot
      cmake
      #clang-tools
      capnproto
      cookiecutter
      curl
      docker
      docker-compose
      du-dust
      entr
      exercism
      fd
      fswatch
      #gcc
      # https://github.com/NixOS/nixpkgs/tree/master/pkgs/applications/version-management/git-and-tools
      gitAndTools.git-extras
      gitAndTools.lefthook
      gitAndTools.tig
      glow
      gping
      graphviz
      hyperfine
      netcat-gnu
      plantuml
      # poetry
      procs
      python39Custom
      python39Packages.pipx
      ripgrep
      rsync
      socat
      vhs
      watch
      wget
      yq

      # Prompt/shell-theme tools
      vivid

      # LSP
      # - Bash
      nodePackages.bash-language-server
      shellcheck
      shfmt # via null-ls
      # - Lua
      sumneko-lua-language-server
      #luaformatter
      # - Nix
      nil
      #nixfmt
      # - Python
      # See `Python39Custom` above for most of
      # the LSP packages.
      ruff
      # - Rust
      rust-analyzer
      # - Typescript/Javascript
      nodePackages.vscode-langservers-extracted
      nodePackages.eslint
      nodePackages.eslint_d
      # Docker
      hadolint # via null-ls
      # Markdown
      nodePackages.markdownlint-cli2 # via null-ls
      # YAML
      python39Packages.yamllint # via null-ls
      #alejandra
      #buf
      #cppcheck
      #gitlint
      #html-tidy
      #python39Packages.jsonschema
      #selene
      #statix
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
