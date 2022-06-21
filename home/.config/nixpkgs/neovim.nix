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

    extraConfig = "lua <<EOF
${builtins.readFile neovim/init.lua}
EOF

${builtins.readFile neovim/init.vim}";

    plugins = with pkgs.vimPlugins; [
      ale
      camelcasemotion
      dracula-vim
      gitsigns-nvim
      gundo
      nvim-treesitter
      plantuml-syntax
      # rust-vim
      vim-abolish
      vim-airline
      vim-airline-themes
      vim-better-whitespace
      vim-commentary
      vim-eunuch
      # vim-fish
      vim-markdown
      # vim-nix
      vim-repeat
      vim-surround
      # vim-toml
    ];
  };
}
