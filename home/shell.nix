# From: https://medium.com/@ejpcmac/about-using-nix-in-my-development-workflow-12422a1f2f4c

# This defines a function taking `pkgs` as parameter, and uses
# `nixpkgs` by default if no argument is passed to it.
{ pkgs ? import <nixpkgs> {} }:

# This avoids typing `pkgs.` before each package name.
with pkgs;

# Defines a shell.
mkShell {
    buildInputs = [
        bat
        docker
        git
        hyperfine
        jq
        neovim
        nix
        python3
        python37Packages.pip
        ripgrep
        rubocop
        ruby
        shfmt
        tmux
        tree
        zsh
    ];

    # https://github.com/NixOS/nix/issues/599
    LOCALE_ARCHIVE=/usr/lib/locale/locale-archive;
}

