{pkgs, ...}: {
  programs.nixvim = {
    enable = true;

    # colorschemes.one.enable = true;

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

    diagnostics = {
      virtual_text = false; # Disabled per `lsp-lines` plugin recommendation.
      # virtual_lines = {only_current_line = true;}; # Only show diagnostic for current line.
    };

    extraPackages = with pkgs; [
    ];

    plugins = {
      airline = {
        enable = true;
        settings = {
          powerline_fonts = true;
          theme = "solarized";
        };
      };
      comment.enable = true; # https://github.com/numtostr/comment.nvim/
      conform-nvim = {
        # https://github.com/stevearc/conform.nvim
        enable = true;
        extraOptions = {
          format_on_save = {
            timeout_ms = 500;
            lsp_format = "fallback";
          };
        };
        formattersByFt = {
          "*" = ["codespell"];
          cmake = ["cmake-format"];
          lua = ["stylua"];
          nix = ["alejandra"];
          python = ["isort" "black"];
          sh = ["shfmt"];
          # Use the "_" filetype to run formatters on filetypes that don't have other formatters configured.
          #"_" = [ "trim_whitespace" ];
        };
      };
      fidget.enable = true;
      gitsigns.enable = true;
      lsp = {
        enable = true;
        servers = {
          bashls.enable = true; # Bash - https://github.com/bash-lsp/bash-language-server
          lua-ls.enable = true; # Lua - https://github.com/luals/lua-language-server
          nil-ls.enable = true; # Nix - https://github.com/oxalica/nil
          ruff.enable = true; # Python
        };
      };
      lsp-lines.enable = true; # https://git.sr.ht/~whynothugo/lsp_lines.nvim
      plantuml-syntax.enable = true;
      surround.enable = true; # https://github.com/tpope/vim-surround
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
      todo-comments.enable = true; # https://github.com/folke/todo-comments.nvim
      treesitter = {
        # https://github.com/nvim-treesitter/nvim-treesitter/
        enable = true;
        folding = true;
      };
    };

    extraPlugins = with pkgs.vimPlugins; [
      camelcasemotion # https://github.com/bkad/camelcasemotion/
      vim-abolish # https://github.com/tpope/vim-abolish/
      vim-airline-themes # https://github.com/vim-airline/vim-airline-themes/tree/master/autoload/airline/themes
      vim-better-whitespace # https://github.com/ntpeters/vim-better-whitespace
      vim-eunuch # https://github.com/tpope/vim-eunuch/
      vim-repeat # https://github.com/tpope/vim-repeat/
      (pkgs.vimUtils.buildVimPlugin {
        #https://github.com/maxmx03/solarized.nvim
        name = "solarized";
        src = pkgs.fetchFromGitHub {
          owner = "maxmx03";
          repo = "solarized.nvim";
          rev = "b3a976585551d93370fbac3c662ae254724ba103";
          hash = "sha256-5qZuXzt8727SiRcTyM/BoYU2rjo/9/m3zEb6+iQw9rU=";
        };
      })
    ];

    opts = {
      autoindent = true; # Always enable auto-indenting.
      backup = false; # Don't keep a backup file.
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

      # Folding.
      foldenable = true;
      foldcolumn = "2"; # Reserve space for the fold.
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

      background = "light";
    };

    autoCmd = [
      # autocmd FileType html setlocal shiftwidth=2 tabstop=2
      {
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
