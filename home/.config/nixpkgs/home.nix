{
  config,
  pkgs,
  ...
}: let
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
      requests
      boto3
      botocore
      requests
      git-remote-codecommit
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
    '';
  };
in {
  imports = [
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

  home.packages = with pkgs;
    [
      #platformio
      asciinema
      cmake
      clang-tools
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
      universal-ctags
      watch
      wget
      yq

      # Prompt/shell-theme tools
      starship
      vivid

      # Formatters/linters
      alejandra
      buf
      cppcheck
      deadnix
      gitlint
      hadolint
      luaformatter
      nixfmt
      nodePackages.eslint_d
      nodePackages.jsonlint
      nodePackages.markdownlint-cli
      nodePackages.pyright
      python39Packages.black
      python39Packages.jsonschema
      python39Packages.pipx
      python39Packages.yamllint
      python39Packages.yapf
      rubocop
      rust-analyzer
      selene
      shellcheck
      shfmt
      statix
      html-tidy
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
