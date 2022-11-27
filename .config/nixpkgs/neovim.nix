{pkgs, ...}: {
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
      camelcasemotion
      cmp-buffer
      cmp-calc
      cmp-cmdline
      cmp_luasnip
      cmp-nvim-lsp
      cmp-path
      dracula-vim
      friendly-snippets
      gitsigns-nvim
      gundo
      indent-blankline-nvim
      lsp-colors-nvim
      luasnip
      null-ls-nvim
      nvim-cmp
      nvim-lspconfig
      (nvim-treesitter.withPlugins (
        plugins:
          with plugins; [
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
          ]
      ))
      plantuml-syntax
      plenary-nvim
      rust-tools-nvim
      tagbar
      toggle-lsp-diagnostics
      trouble-nvim
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
