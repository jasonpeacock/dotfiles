-- Lua configuration for Neovim

--# selene: allow(undefined_variable, unscoped_variables)

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

-- Enable wildmenu support, which autocompletes commands.
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

-- Use GUI-based colors even when run within a terminal,
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
    -- Grammars are installed via `neovim.nix` so that they
    -- are compiled correctly for Nix. Otherwise you get an
    -- error from dlopen about not being able to find stdlibc.6.so
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

-- null-ls-nvim
require("null-ls").setup({
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTIN_CONFIG.md
    sources = {
        require("null-ls").builtins.code_actions.gitsigns,        -- git
        require("null-ls").builtins.code_actions.proselint,       -- english
        require("null-ls").builtins.code_actions.refactoring,     -- generic code
        require("null-ls").builtins.code_actions.shellcheck,      -- bash
        require("null-ls").builtins.code_actions.statix,          -- nix
        require("null-ls").builtins.code_actions.eslint_d,        -- javascript/typescript
        require("null-ls").builtins.formatting.alejandra,         -- nix
        require("null-ls").builtins.formatting.black,             -- python
        require("null-ls").builtins.formatting.buf,               -- protocol buffers
        require("null-ls").builtins.formatting.clang_format,      -- C/C++
        require("null-ls").builtins.formatting.cmake_format,      -- cmake
        require("null-ls").builtins.formatting.codespell,         -- spelling in code
        require("null-ls").builtins.formatting.eslint_d,          -- javascript/typescript
        require("null-ls").builtins.formatting.fish_indent,       -- fish
        require("null-ls").builtins.formatting.isort,             -- python
        require("null-ls").builtins.formatting.jq,                -- json
        require("null-ls").builtins.formatting.lua_format,        -- lua
        require("null-ls").builtins.formatting.markdownlint,      -- markdown
        require("null-ls").builtins.formatting.nixfmt,            -- nix
        require("null-ls").builtins.formatting.nixpkgs_fmt,       -- nix
        require("null-ls").builtins.formatting.rubocop,           -- ruby
        require("null-ls").builtins.formatting.rustfmt,           -- rust
        require("null-ls").builtins.formatting.shellharden,       -- bash
        require("null-ls").builtins.formatting.shfmt.with({       -- bash
             extra_args = {"-i", "2", "-ci", "-sr", "-kp"}  -- Make shfmt pretty.
        }),
        require("null-ls").builtins.formatting.tidy,              -- html
        require("null-ls").builtins.diagnostics.eslint_d,         -- javascript/typescript
        require("null-ls").builtins.diagnostics.alex,             -- english
        require("null-ls").builtins.diagnostics.buf,              -- protocol buffers
        --XXX require("null-ls").builtins.diagnostics.cfn_lint,         -- cloud formation templates
        require("null-ls").builtins.diagnostics.checkmake,        -- make
        require("null-ls").builtins.diagnostics.codespell,        -- english
        require("null-ls").builtins.diagnostics.cppcheck,         -- C/C++
        require("null-ls").builtins.diagnostics.deadnix,          -- nix
        require("null-ls").builtins.diagnostics.fish,             -- fish
        require("null-ls").builtins.diagnostics.flake8.with({     -- python
             extra_args = {"--max-line-length", "88"}  -- Match the line-length of Black.
         }),
        require("null-ls").builtins.diagnostics.gitlint,          -- git commit messages
        require("null-ls").builtins.diagnostics.hadolint,         -- dockerfile
        require("null-ls").builtins.diagnostics.jsonlint,         -- json
        require("null-ls").builtins.diagnostics.markdownlint,     -- markdown
        require("null-ls").builtins.diagnostics.mypy,             -- python
        require("null-ls").builtins.diagnostics.proselint,        -- english
        require("null-ls").builtins.diagnostics.pydocstyle,       -- python
        require("null-ls").builtins.diagnostics.pyproject_flake8, -- python
        require("null-ls").builtins.diagnostics.rubocop,          -- ruby
        require("null-ls").builtins.diagnostics.selene,           -- lua
        require("null-ls").builtins.diagnostics.shellcheck.with({ -- bash
             extra_args = {"-s", "bash", "-e", "SC1008"}  -- Force shellcheck to always assume Bash,
                                                          -- and ignore warning about unsupported #!.
        }),
        require("null-ls").builtins.diagnostics.statix,           -- nix
        require("null-ls").builtins.diagnostics.tidy,             -- html
        require("null-ls").builtins.diagnostics.vulture,          -- python
        require("null-ls").builtins.diagnostics.yamllint,         -- yaml
        require("null-ls").builtins.completion.spell,             -- spell
        require("null-ls").builtins.completion.tags,              -- tags
    },
})

-- nvim-cmp
vim.opt.completeopt = {"menu", "menuone", "noselect"}
local cmp = require("cmp")
cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    window = {
        -- completion = cmp.config.window.bordered(),
        -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
    }, {
            { name = 'buffer' },
        })
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
        { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
            { name = 'buffer' },
        })
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
            { name = 'cmdline' }
        })
})

-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
require('lspconfig')['rust_analyzer'].setup {
    capabilities = capabilities
}

-- luasnip
require("luasnip.loaders.from_vscode").lazy_load() -- Load VSCode-like snippets, e.g. from `friendly-snippets`

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
vim.keymap.set("", "Y", "y$", {desc = "Yank from cursor to the end of the line"})

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
