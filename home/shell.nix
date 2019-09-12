# From: https://medium.com/@ejpcmac/about-using-nix-in-my-development-workflow-12422a1f2f4c

# This defines a function taking `pkgs` as parameter, and uses
# `nixpkgs` by default if no argument is passed to it.
{ pkgs ? import <nixpkgs> {} }:

# This avoids typing `pkgs.` before each package name.
with pkgs;

# Defines a shell.
mkShell {
    buildInputs = [
        awscli
        bat
        docker
        git
        hyperfine
        jq
        neovim
        nix
        plantuml
        python3
        python37Packages.pip
        python37Packages.setuptools
        ripgrep
        rubocop
        ruby
        shfmt
        tmux
        tree
        zsh
    ];

    # Fix font chars not recognized due to locale issues.
    # https://github.com/NixOS/nix/issues/599
    LOCALE_ARCHIVE=/usr/lib/locale/locale-archive;
}
