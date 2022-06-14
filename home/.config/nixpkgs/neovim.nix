{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    package = pkgs.neovim-unwrapped;
    viAlias = false;
    vimAlias = false;

    withNodeJs = false;
    withPython3 = true;
    withRuby = false;

    extraConfig = builtins.readFile neovim/neovimrc;

    plugins = with pkgs.vimPlugins; [
      ale
      camelcasemotion
      dracula-vim
      elm-vim
      gundo
      plantuml-syntax
      rust-vim
      vim-abolish
      vim-airline
      vim-airline-themes
      vim-better-whitespace
      vim-commentary
      vim-eunuch
      vim-gitgutter
      vim-markdown
      vim-nix
      vim-repeat
      vim-surround
      vim-toml
    ];
  };
}
