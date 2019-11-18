{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    package = pkgs.neovim-unwrapped;
    viAlias = false;
    vimAlias = false;

    withNodeJs = false;
    withPython = false;
    withPython3 = true;
    withRuby = true;

    extraConfig = builtins.readFile neovim/neovimrc;

    plugins = with pkgs.vimPlugins; [
      ale
      camelcasemotion
      elm-vim
      gundo
      plantuml-syntax
      rust-vim
      vim-abolish
      vim-airline
      vim-airline-themes
      vim-better-whitespace
      vim-colors-solarized
      vim-commentary
      vim-eunuch
      vim-markdown
      vim-nix
      vim-repeat
      vim-surround
      vim-toml
    ];

  };
}
