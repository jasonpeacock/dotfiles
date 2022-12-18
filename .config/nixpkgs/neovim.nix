{pkgs, ...}: {
  programs.neovim = {
    enable = true;
    package = pkgs.neovim-unwrapped;
    viAlias = false;
    vimAlias = false;

    withNodeJs = true;
    withPython3 = true;
    withRuby = true;

    extraConfig = "lua <<EOF
${builtins.readFile neovim/init.lua}
EOF
";

    plugins = with pkgs.vimPlugins; let
      toggle-lsp-diagnostics = pkgs.vimUtils.buildVimPlugin {
        name = "toggle-lsp-diagnostics";
        src = pkgs.fetchFromGitHub {
          owner = "whoissethdaniel";
          repo = "toggle-lsp-diagnostics.nvim";
          rev = "32fd1d3505a1ae931709e750836a4b90596f1257";
          sha256 = "a7Jiq6hzaNEbBcMPgaL5IywHtDqMRDIP3O4sZKDVA58=";
        };
      };
    in [
      # LSP
      nvim-lspconfig
      fidget-nvim
      lsp-colors-nvim
      lsp-format-nvim
      rust-tools-nvim
      toggle-lsp-diagnostics
      #lspsaga-nvim  # TODO try this later
      # Autocomplete
      nvim-cmp
      cmp-buffer
      cmp-cmdline
      cmp-nvim-lsp
      cmp-path
      # Snippets
      luasnip
      cmp_luasnip
      friendly-snippets
      # Other
      camelcasemotion
      dracula-vim
      gitsigns-nvim
      indent-blankline-nvim
      #gundo
      #null-ls-nvim
      (nvim-treesitter.withPlugins (
        plugins:
          with plugins; [
            tree-sitter-bash
            tree-sitter-c
            tree-sitter-cmake
            tree-sitter-comment
            tree-sitter-cpp
            tree-sitter-css
            tree-sitter-diff
            tree-sitter-dockerfile
            tree-sitter-dot
            tree-sitter-fish
            tree-sitter-gitignore
            tree-sitter-go
            tree-sitter-html
            tree-sitter-javascript
            tree-sitter-json
            tree-sitter-lua
            tree-sitter-make
            tree-sitter-markdown
            tree-sitter-markdown_inline
            tree-sitter-nix
            tree-sitter-python
            tree-sitter-rust
            tree-sitter-tlaplus
            tree-sitter-toml
            tree-sitter-vim
            tree-sitter-yaml
          ]
      ))
      plantuml-syntax
      plenary-nvim
      popup-nvim
      tagbar
      telescope-nvim
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
