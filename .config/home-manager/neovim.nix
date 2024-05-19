{pkgs, ...}: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    package = pkgs.neovim-unwrapped;
    viAlias = false;
    vimAlias = false;

    withNodeJs = true;
    withPython3 = true;
    withRuby = true;

    extraLuaConfig = builtins.readFile neovim/nix.lua;

    extraPackages = with pkgs; [
      # Bash
      nodePackages.bash-language-server
      # Typescript/Javascript
      #nodePackages.vscode-langservers-extracted
      nodePackages.eslint
      #nodePackages.eslint_d
      # Docker
      hadolint
      # Markdown
      nodePackages.markdownlint-cli2
      # Python
      python310Packages.python-lsp-server
      python310Packages.python-lsp-black
      python310Packages.python-lsp-ruff
      python310Packages.pylsp-mypy
      # Nix
      nil
      #nixfmt
      # Git
      gitlint
      # Lua
      #selene
      #sumneko-lua-language-server
      #luaformatter
      # Ruby
      #rubocop
      # YAML
      #python310Packages.yamllint # via null-ls
      #alejandra
      #buf
      #cppcheck
      #html-tidy
      #python310Packages.jsonschema
      #statix
    ];

    #extraLuaPackages = ps: let
    #in [
    #];

    plugins = with pkgs.vimPlugins; let
      none-ls-extras = pkgs.vimUtils.buildVimPlugin {
        name = "none-ls-extras";
        src = pkgs.fetchFromGitHub {
          owner = "nvimtools";
          repo = "none-ls-extras.nvim";
          rev = "336e84b9e43c0effb735b08798ffac382920053b";
          sha256 = "UtU4oWSRTKdEoMz3w8Pk95sROuo3LEwxSDAm169wxwk=";
        };
      };
    in [
      fidget-nvim
      # LSP
      nvim-lspconfig
      lsp-format-nvim
      lsp-colors-nvim
      plenary-nvim # dependency of none-ls-nvim
      none-ls-nvim
      none-ls-extras
      rustaceanvim
      #plantuml-syntax
      #toggle-lsp-diagnostics
      #lspsaga-nvim
      # Autocomplete
      #nvim-cmp
      #cmp-buffer
      #cmp-cmdline
      #cmp-nvim-lsp
      #cmp-path
      # Snippets
      #luasnip
      #cmp_luasnip
      #friendly-snippets
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
            tree-sitter-ruby
            tree-sitter-rust
            tree-sitter-tlaplus
            tree-sitter-toml
            tree-sitter-vim
            tree-sitter-yaml
          ]
      ))
      # Themes
      # dracula-vim
      # onenord-nvim
      # nordic-nvim
      # nord-vim
      solarized-nvim
      nvim-solarized-lua
      # popup-nvim
      # tagbar
      telescope-nvim
      gitsigns-nvim
      camelcasemotion
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
