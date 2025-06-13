{pkgs, ...}: {
  programs.nixvim = {
    enable = true;

    # colorschemes.gruvbox.enable = true;
    colorschemes.base16 = {
      enable = true;
      colorscheme = "gruvbox-dark-soft";
    };

    extraConfigLua = builtins.readFile neovim/nix.lua;

    globals = {
      mapleader = " "; # Use spacebar for leader key, instead of '\'.

      # camelcasemotion
      camelcasemotion_key = "<leader>";

      # vim-better-whitespace
      better_whitespace_enabled = 1;
      better_whitespace_filetypes_blacklist = ["diff" "gitcommit" "git" "help"];
      show_spaces_that_precede_tabs = 1;
      strip_whitelines_at_eof = 1;
      strip_whitespace_confirm = 0;
      strip_whitespace_on_save = 1;
    };

    diagnostic.settings = {
      virtual_text = false; # Disabled per tiny-inline-diagnostic plugin recommendation.
      # virtual_lines = {only_current_line = true;}; # Only show diagnostic for current line.
    };

    extraPackages = with pkgs; [
      lombok # required for `nvim-jdtls` LSP server for Java
    ];

    extraFiles = {
      "ftplugin".source = neovim/ftplugin;
    };

    plugins = {
      airline = {
        enable = true;
        settings = {
          powerline_fonts = 1;
          theme = "base16_gruvbox_dark_hard";
        };
      };
      comment.enable = true; # https://github.com/numtostr/comment.nvim/
      conform-nvim = {
        # https://github.com/stevearc/conform.nvim
        enable = true;
        settings = {
          format_on_save = {
            timeout_ms = 500;
            lsp_format = "fallback";
          };
          formatters_by_ft = {
            #"*" = ["codespell"];
            cmake = ["cmake-format"];
            javascript = ["eslint_d"];
            json = ["jq"];
            lua = ["stylua"];
            markdown = ["markdownlint-cli2"];
            nix = ["alejandra"];
            python = ["isort" "black"];
            rust = ["rustfmt"];
            sh = ["shfmt"];
            typescript = ["eslint_d"];
          };
        };
      };
      fidget.enable = true;
      gitsigns.enable = true; # https://github.com/lewis6991/gitsigns.nvim/
      glow.enable = true; # https://github.com/ellisonleao/glow.nvim/
      lastplace.enable = true; # https://github.com/farmergreg/vim-lastplace
      lsp = {
        enable = true;
        servers = {
          bashls.enable = true; # Bash - https://github.com/bash-lsp/bash-language-server
          eslint.enable = true; # JS/TS - https://github.com/hrsh7th/vscode-langservers-extracted
          # See `nvim-jdtls` for Java LSP support.
          jsonls.enable = true; # JSON - https://github.com/hrsh7th/vscode-langservers-extracted
          lua_ls.enable = true; # Lua - https://github.com/luals/lua-language-server
          marksman.enable = true; # Markdown - https://github.com/artempyanykh/marksman
          nil_ls.enable = true; # Nix - https://github.com/oxalica/nil
          # perlnavigator.enable = true; # Perl - https://github.com/bscan/PerlNavigator
          ruff.enable = true; # Python - https://github.com/astral-sh/ruff
          # See `rustaceanvim` below for Rust LSP
        };
      };
      nvim-ufo.enable = true; # https://github.com/kevinhwang91/nvim-ufo
      none-ls = {
        enable = true;
        enableLspFormat = false;
        sources = {
          diagnostics = {
            markdownlint_cli2 = {
              enable = true;
              settings = {
                args = ["$FILENAME"];
                extra_args = ["--disable MD013 --"];
                #extra_args = [ "--disable MD013 MD046 --" ];
              };
            };
          };
        };
      };
      plantuml-syntax.enable = true;
      rustaceanvim.enable = true; # Rust - https://github.com/mrcjkb/rustaceanvim
      tagbar.enable = true; # https://github.com/preservim/tagbar/
      telescope = {
        enable = true;
        keymaps = {
          "<leader>ff" = {
            action = "find_files";
            options = {
              desc = "Telescope Files";
            };
          };
          "<leader>fg" = "live_grep";
          "<leader>fb" = "buffers";
          "<leader>fh" = "help_tags";
        };
      };
      tiny-inline-diagnostic = {
        # https://github.com/rachartier/tiny-inline-diagnostic.nvim/
        enable = true;
        settings = {
          preset = "powerline";
          options = {
            multilines = {
              enabled = true;
              always_show = true;
            };
          };
        };
      };
      todo-comments.enable = true; # https://github.com/folke/todo-comments.nvim
      treesitter = {
        # https://github.com/nvim-treesitter/nvim-treesitter/
        enable = true;
        # folding = true; # using `nvim-ufo` instead
      };
      vim-surround.enable = true; # https://github.com/tpope/vim-surround
      web-devicons.enable = true;
    };

    extraPlugins = with pkgs.vimPlugins; [
      camelcasemotion # https://github.com/bkad/camelcasemotion/
      nvim-jdtls # https://github.com/mfussenegger/nvim-jdtls
      vim-abolish # https://github.com/tpope/vim-abolish/
      vim-airline-themes # https://github.com/vim-airline/vim-airline-themes/tree/master/autoload/airline/themes
      vim-better-whitespace # https://github.com/ntpeters/vim-better-whitespace
      vim-eunuch # https://github.com/tpope/vim-eunuch/
      vim-repeat # https://github.com/tpope/vim-repeat/
    ];

    opts = {
      autoindent = true; # Always enable auto-indenting.
      backup = false; # Don't keep a backup file.
      # conceallevel = 1; # Hide formatting characters (e.g. quotes around strings in JSON, or Markdown chars)
      encoding = "utf8"; # Set standard file encoding.
      errorbells = false; # Be quiet.
      formatoptions = "tcrq"; # Continue comments on new lines, default is: tcqj (:help fo-table)
      mouse = "a"; # Enable the mouse.
      number = true; # Turn on line numbers.
      # relativenumber = true;   # Show the line numbers as relative.
      showmatch = true; # Show matching brackets.
      showmode = false; # Statusline shows the mode itself, don't duplicate it.
      swapfile = false; # Don't use swap files.
      undolevels = 100; # Adjust system undo levels.
      updatetime = 100; # Write to swap file faster, and makes vim-gitgutter more responsive.
      wmh = 0; # Set smallest possible window when minimizing a split window.

      wildmenu = true; # Enable wildmenu support, which autocompletes commands.
      wildmode = "list:longest,full"; # List all options, match to the longest.

      # Tabs & indents
      expandtab = true;
      shiftwidth = 4;
      softtabstop = 4;
      tabstop = 4;
      shiftround = true;
      backspace = ["indent" "eol" "start"];

      # Folding.
      foldenable = true;
      foldcolumn = "0"; # Reserve space for the fold. "auto:9" is pretty & fancy.
      foldlevel = 99;
      foldlevelstart = 99; # All folds are open by default.

      # Searching.
      hlsearch = true; # Use search highlighting.
      ignorecase = true; # Do case insensitive searching.
      incsearch = true; # Perform incremental searching.
      smartcase = true; # Ignore case unless case is used.

      # Put the Git signs/LSP diagnostics/etc into the number column, stop all the sideways jumping around.
      signcolumn = "number";

      # Use GUI-based colors even when run within a terminal, this pushes VIM to support truecolors.
      termguicolors = true;

      background = "dark";
    };

    # Make comments stand out & easier to read.
    highlightOverride = {
      Comment = {
        fg = "LightRed";
        italic = true;
      };
      TSComment = {
        fg = "LightRed";
        italic = true;
      };
    };

    autoCmd = [
      # Set shorter tabstops for some files.
      {
        command = "setlocal shiftwidth=2 tabstop=2 softtabstop=2";
        event = "FileType";
        pattern = ["html" "nix" "sh"];
      }
      # Don't break Makefiles, which require actual tabs.
      {
        command = "setlocal noexpandtab";
        event = "FileType";
        pattern = ["make"];
      }
      # BuilderHub docs are `rst`, set width to 100.
      {
        command = "setlocal textwidth=100 colorcolumn=100";
        event = "FileType";
        pattern = ["rst"];
      }
    ];

    keymaps = [
      # Make Y yank everything from the cursor to the end of the line. This makes Y
      # act more like C or D because by default, Y yanks the current line (i.e. the
      # same as yy).
      {
        mode = "";
        key = "Y";
        action = "y$";
        options.desc = "Yank from cursor to the end of the line";
      }

      # Turn off the search highlight.
      {
        mode = "n";
        key = "<leader><space>";
        action = ":nohlsearch<CR>";
        options.desc = "Turn off the search highlight";
      }

      # Map ctrl-h/j/k/l to move between split windows.
      {
        mode = "";
        key = "<c-h>";
        action = "<c-w>j<c-w>_";
        options.desc = "Move left to window split";
      }
      {
        mode = "";
        key = "<c-j>";
        action = "<c-w>j<c-w>_";
        options.desc = "Move down to window split";
      }
      {
        mode = "";
        key = "<c-k>";
        action = "<c-w>k<c-w>_";
        options.desc = "Move up to window split";
      }
      {
        mode = "";
        key = "<c-l>";
        action = "<c-w>l<c-w>_";
        options.desc = "Move right to window split";
      }

      # Delete a selection w/o updating the buffer.
      {
        mode = "";
        key = "x";
        action = "\"_x";
        options.desc = "Delete (d) without updating the buffer";
      }
      {
        mode = "";
        key = "X";
        action = "\"_X";
        options.desc = "Delete (D) without updating the buffer";
      }

      # Move up/down over wrapped lines in a nice manner.
      {
        mode = "";
        key = "j";
        action = "(v:count == 0 ? 'gj' : 'j')";
        options.expr = true;
        options.silent = true;
      }
      {
        mode = "";
        key = "k";
        action = "(v:count == 0 ? 'gk' : 'k')";
        options.expr = true;
        options.silent = true;
      }
    ];
  };

  #
  # NOTES
  #

  # Restore cursor style on exit.
  # vim.cmd("au VimLeave * set guicursor=a:hor25-blinkon0")

  # Fix grey background in Vim for dracula
  # https://github.com/dracula/vim/issues/96
  #vim.g.dracula_colorterm = 0

  # https://stackoverflow.com/questions/3494435/vimrc-make-comments-italic
  # https://stackoverflow.com/questions/5830125/how-to-change-font-color-for-comments-in-vim
  # https://upload.wikimedia.org/wikipedia/commons/1/15/Xterm_256color_chart.svg
  # vim.cmd("highlight Comment cterm=italic ctermfg=225")
}
