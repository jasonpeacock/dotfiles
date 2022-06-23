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
";

    plugins = with pkgs.vimPlugins; [
      camelcasemotion
      cmp-buffer
      cmp-calc
      cmp-cmdline
      cmp-dictionary
      cmp-git
      cmp_luasnip
      cmp-nvim-lsp
      cmp-path
      cmp-conventionalcommits
      dracula-vim
      friendly-snippets
      gitsigns-nvim
      gundo
      luasnip
      null-ls-nvim
      nvim-cmp
      nvim-lspconfig
      # (nvim-treesitter.withPlugins (_: pkgs.tree-sitter.allGrammars))
      (nvim-treesitter.withPlugins (
        plugins: with plugins; [
          tree-sitter-bash
          tree-sitter-c
          tree-sitter-cmake
          tree-sitter-cpp
          tree-sitter-css
          tree-sitter-dockerfile
          tree-sitter-fish
          tree-sitter-html
          tree-sitter-json
          tree-sitter-lua
          tree-sitter-make
          tree-sitter-markdown
          tree-sitter-nix
          tree-sitter-python
          tree-sitter-rust
          tree-sitter-tlaplus
          tree-sitter-toml
          tree-sitter-vim
          tree-sitter-yaml
        ]))
      plantuml-syntax
      plenary-nvim
      vim-abolish
      vim-airline
      vim-airline-themes
      vim-better-whitespace
      vim-commentary
      vim-eunuch
      vim-repeat
      vim-surround
    ];
  };
}
