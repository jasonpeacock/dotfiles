-- Lua configuration for Neovim

-- Use spacebar for leader key, instead of '\'.
vim.g.mapleader = " "

--vim.opt.autoindent = true             -- Always enable auto-indenting.
--vim.opt.clipboard-unnamed = true      -- Use system clipboard.
--vim.opt.laststatus = 2                -- Always have a status bar.
--vim.opt.wrap = false                  -- Stop word wrapping.
--vim.opt.scrolloff = 1                 -- Space above cursor from screen edge.
--vim.opt.sidescrolloff = 5             -- Space beside cursor from screen edge.
--vim.opt.cursorcolumn = true           -- Highlight the current column.
--vim.opt.cursorline = true             -- Highlight the current line.
--vim.opt.lazyredraw = true             -- Redraw only when needed, speeds up macros.
--vim.opt.conceallevel = 0              -- Don't hide characters.
vim.opt.encoding = "utf8"             -- Set standard file encoding.
vim.opt.mouse = "a"                   -- Enable the mouse.
vim.opt.backup = false                -- Don't keep a backup file
vim.opt.errorbells = false            -- Be quiet.
vim.opt.swapfile = false              -- Don't use swap files.
vim.opt.showmatch = true              -- Show matching brackets.
vim.opt.updatetime = 100              -- Write to swap file faster, and makes vim-gitgutter more responsive
vim.opt.undolevels = 100              -- Adjust system undo levels.
vim.opt.wmh = 0                       -- Set smallest possible window when minimizing a split window.
vim.opt.number = true                 -- Turn on line numbers.
--vim.opt.relativenumber = true         -- Show the line numbers as relative.

--vim.opt.spell = true                  -- Enable spell check.
--vim.opt.spellcapcheck = true          -- Disable capitalization check.

-- Fix behavior to continue comments on new lines, default is: tcqj
-- :help fo-table
vim.opt.formatoptions = "tcrq"

-- Enable wildmenu support, which autocompletes commmands.
vim.opt.wildmenu = true
vim.opt.wildmode = "list:longest,full"  -- list all options, match to the longest

-- Set tab width & convert tabs to spaces.
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.tabstop = 4
-- Round all shifts to be a multiple of `shiftwidth`.
vim.opt.shiftround = true

-- Support folding.
vim.opt.foldenable = true             -- Enable folding.
--vim.opt.foldcolumn = 2                -- Reserve space for the fold.
vim.opt.foldlevelstart = 99           -- All folds are open by default.
--vim.opt.foldmethod = "indent"           -- Use indenting to determine folds.
--vim.opt.foldmethod = syntax           -- Use syntax rules to determine folds.
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

-- Searching.
vim.opt.hlsearch = true               -- Use search highlighting.
vim.opt.ignorecase = true             -- Do case insensitive searching.
vim.opt.incsearch = true              -- Perform incremental searching.
vim.opt.smartcase = true              -- Ignore case unless case is used.

-- Fix grey background in Vim for dracula
-- https://github.com/dracula/vim/issues/96
-- let g:dracula_colorterm = 0

-- Use GUI-based colors even when run withing a terminal,
-- this pushes VIM to support truecolors and fixes the
-- grey background in the Dracula theme
vim.opt.termguicolors = true

vim.cmd("colorscheme dracula")
vim.opt.background = "dark"

-- vim-airline
vim.g.airline_powerline_fonts = 1
vim.g.airline_theme = "dracula"

-- vim-better-whitespace
vim.g.better_whitespace_filetypes_blacklist = {"diff", "gitcommit"} -- Filetypes to skip stripping of whitespace.
vim.g.strip_whitelines_at_eof = 1
vim.g.show_spaces_that_precede_tabs = 1
vim.g.strip_whitespace_confirm = 0
vim.g.strip_whitespace_on_save = 1

-- gitsigns-nvim
require('gitsigns').setup()

-- nvim-treesitter
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = {
    "bash",
    "c",
    "cmake",
    "cpp",
    "css",
    "dockerfile",
    "fish",
    "html",
    "json",
    "lua",
    "make",
    "markdown",
    "nix",
    "python",
    "rust",
    "tlaplus",
    "toml",
    "vim",
    "yaml",
  },
  highlight = {
    enable = true,
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
  indent = {
    enable = true
  }
}

-- camelcasemotion
vim.g.camelcasemotion_key = "<leader>"

vim.cmd([[
augroup configgroup
    autocmd!
    autocmd VimEnter * highlight clear SignColumn

    " Strip trailing whitespace from all files. See the configuration in
    " plugins.vimrc for a blacklist of filetypes.
    autocmd BufEnter * EnableStripWhitespaceOnSave

    " Allow word wrapping for some filetypes.
    autocmd BufNewFile,BufReadPost *.md set filetype=markdown
    autocmd FileType markdown setlocal wrap
    autocmd FileType markdown setlocal conceallevel=0

    " YAML style is 2-space indenting.
    autocmd FileType yaml setlocal tabstop=2
    autocmd FileType yaml setlocal shiftwidth=2
    autocmd FileType yaml setlocal softtabstop=2
    autocmd FileType yaml setlocal commentstring=#\ %s

    " Bash style is 2-space indenting.
    autocmd FileType sh setlocal tabstop=2
    autocmd FileType sh setlocal shiftwidth=2
    autocmd FileType sh setlocal softtabstop=2
    autocmd FileType sh setlocal commentstring=#\ %s

    " Ruby style is 2-space indenting.
    autocmd FileType ruby setlocal tabstop=2
    autocmd FileType ruby setlocal shiftwidth=2
    autocmd FileType ruby setlocal softtabstop=2
    autocmd FileType ruby setlocal commentstring=#\ %s

    autocmd FileType python setlocal commentstring=#\ %s

    " Map unknown files to known filetypes.
    autocmd BufEnter *.cls setlocal filetype=java
    autocmd BufEnter *.zsh-theme setlocal filetype=zsh
    autocmd BufEnter *.launch setlocal filetype=xml " ROS .launch files are XML
    autocmd BufEnter *.bats set filetype=sh

    " Makefiles need to keep their tabs.
    autocmd BufEnter Makefile setlocal noexpandtab
augroup END
]])

vim.cmd("filetype plugin indent on")
-- vim.cmd("syntax enable")

-- Restore cursor style on exit.
vim.cmd("au VimLeave * set guicursor=a:hor25-blinkon0")

-- Make Y yank everything from the cursor to the end of the line. This makes Y
-- act more like C or D because by default, Y yanks the current line (i.e. the
-- same as yy).
vim.keymap.set("", "Y", "y$", {desc = "Yank from curser to the end of the line"})

-- Turn off the search highlight.
vim.keymap.set("n", "<leader><space>", ":nohlsearch<CR>", {desc = "Turn off the search highlight"})

-- Map ctrl-h/j/k/l to move between split windows.
vim.keymap.set("", "<c-h>", "<c-w>j<c-w>_", {desc = "Move left to window split"})
vim.keymap.set("", "<c-j>", "<c-w>j<c-w>_", {desc = "Move down to window split"})
vim.keymap.set("", "<c-k>", "<c-w>k<c-w>_", {desc = "Move up to window split"})
vim.keymap.set("", "<c-l>", "<c-w>l<c-w>_", {desc = "Move right to window split"})

-- Delete a selection w/o updating the buffer.
vim.keymap.set("v", "x", '"_x', {desc = "Delete (d) without updating the buffer"})
vim.keymap.set("v", "X", '"_X', {desc = "Delete (D) without updating the buffer"})

-- Toggle 'slf/gundo.vim'
vim.keymap.set("n", "<leader>u", ":GundoToggle<CR>", {desc = "Toggle 'Gundo' plugin"})

-- Move up/down over wrapped lines in a nice manner.
vim.keymap.set("", "j", "(v:count == 0 ? 'gj' : 'j')", {expr = true, silent = true})
vim.keymap.set("", "k", "(v:count == 0 ? 'gk' : 'k')", {expr = true, silent = true})
