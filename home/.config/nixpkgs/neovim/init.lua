-- Lua configuration for Neovim
-- # selene: allow(undefined_variable, unscoped_variables)
-- Use spacebar for leader key, instead of '\'.
vim.g.mapleader = " "

vim.opt.autoindent = true -- Always enable auto-indenting.
-- vim.opt.clipboard-unnamed = true      -- Use system clipboard.
-- vim.opt.laststatus = 2                -- Always have a status bar.
-- vim.opt.wrap = false                  -- Stop word wrapping.
-- vim.opt.scrolloff = 1                 -- Space above cursor from screen edge.
-- vim.opt.sidescrolloff = 5             -- Space beside cursor from screen edge.
-- vim.opt.cursorcolumn = true           -- Highlight the current column.
-- vim.opt.cursorline = true             -- Highlight the current line.
-- vim.opt.lazyredraw = true             -- Redraw only when needed, speeds up macros.
-- vim.opt.conceallevel = 0              -- Don't hide characters.
vim.opt.encoding = "utf8" -- Set standard file encoding.
vim.opt.mouse = "a" -- Enable the mouse.
vim.opt.backup = false -- Don't keep a backup file
vim.opt.errorbells = false -- Be quiet.
vim.opt.swapfile = false -- Don't use swap files.
vim.opt.showmatch = true -- Show matching brackets.
vim.opt.updatetime = 100 -- Write to swap file faster, and makes vim-gitgutter more responsive
vim.opt.undolevels = 100 -- Adjust system undo levels.
vim.opt.wmh = 0 -- Set smallest possible window when minimizing a split window.
vim.opt.number = true -- Turn on line numbers.
-- vim.opt.relativenumber = true         -- Show the line numbers as relative.

-- vim.opt.spell = true                  -- Enable spell check.
-- vim.opt.spelllang = { "en_us" }       -- Use US English spelling.

-- Fix behavior to continue comments on new lines, default is: tcqj
-- :help fo-table
vim.opt.formatoptions = "tcrq"

-- Enable wildmenu support, which autocompletes commands.
vim.opt.wildmenu = true
vim.opt.wildmode = "list:longest,full" -- list all options, match to the longest

-- Set tab width & convert tabs to spaces.
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.tabstop = 4
-- Round all shifts to be a multiple of `shiftwidth`.
vim.opt.shiftround = true

-- Support folding.
vim.opt.foldenable = true -- Enable folding.
-- vim.opt.foldcolumn = 2                -- Reserve space for the fold.
vim.opt.foldlevelstart = 99 -- All folds are open by default.
-- vim.opt.foldmethod = "indent"           -- Use indenting to determine folds.
-- vim.opt.foldmethod = syntax           -- Use syntax rules to determine folds.
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

-- Searching.
vim.opt.hlsearch = true -- Use search highlighting.
vim.opt.ignorecase = true -- Do case insensitive searching.
vim.opt.incsearch = true -- Perform incremental searching.
vim.opt.smartcase = true -- Ignore case unless case is used.

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

-- indent-blankline-nvim
require("indent_blankline").setup {
    -- for example, context is off by default, use this to turn it on
    show_current_context = true
    -- show_current_context_start = true
}

-- trouble-nvim
require('trouble').setup()

-- gitsigns-nvim
require('gitsigns').setup {signcolumn = true}

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
        additional_vim_regex_highlighting = {"python"}
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm"
        }
    },
    indent = {enable = true, disable = {"python"}}
}

-- null-ls-nvim
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local diagnostics_msg = "[#{c}] #{m} (#{s})"
local null_ls = require("null-ls")
null_ls.setup({
    diagnostics_format = diagnostics_msg,
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Formatting-on-save
    on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({group = augroup, buffer = bufnr})
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
                    vim.lsp.buf.formatting_sync()
                end
            })
        end
        common_on_attach(client, bufnr)
    end,
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTIN_CONFIG.md
    sources = {
        null_ls.builtins.formatting.trim_newlines.with({
            -- use their specific formatters
            disabled_filetypes = {
                "rust", "python", "bash", "nix", "ruby", "markdown"
            }
        }), null_ls.builtins.formatting.trim_whitespace.with({
            -- use their specific formatters
            disabled_filetypes = {
                "rust", "python", "bash", "nix", "ruby", "markdown"
            }
        }), -- null_ls.builtins.formatting.rustfmt
        --     .with({extra_args = {"--edition=2021"}}),
        -- null_ls.builtins.code_actions.gitsigns, -- Git
        null_ls.builtins.diagnostics.gitlint.with({
            diagnostics_format = diagnostics_msg
        }), -- Git
        -- null_ls.builtins.code_actions.eslint_d, -- Javascript/Typescript
        null_ls.builtins.formatting.eslint_d, -- Javascript/Typescript
        null_ls.builtins.diagnostics.eslint_d.with({
            diagnostics_format = diagnostics_msg
        }), -- Javascript/Typescript
        -- null_ls.builtins.code_actions.refactoring, -- Programming
        null_ls.builtins.completion.tags, -- Programming
        -- null_ls.builtins.code_actions.shellcheck, -- Bash
        null_ls.builtins.formatting.shfmt.with({ -- Bash
            extra_args = {"-i", "2", "-ci", "-sr"}, -- Make shfmt pretty.
            diagnostics_format = diagnostics_msg
        }), null_ls.builtins.diagnostics.shellcheck.with({ -- Bash
            extra_args = {"-s", "bash", "-e", "SC1008"} -- Force shellcheck to always assume Bash,
            -- and ignore warning about unsupported #!.
        }), -- null_ls.builtins.code_actions.statix, -- Nix
        null_ls.builtins.formatting.alejandra, -- Nix
        null_ls.builtins.diagnostics.deadnix.with({
            diagnostics_format = diagnostics_msg
        }), -- Nix
        null_ls.builtins.diagnostics.statix.with({
            diagnostics_format = diagnostics_msg
        }), -- Nix
        null_ls.builtins.formatting.black, -- Python
        null_ls.builtins.diagnostics.flake8.with({ -- Python
            -- only_local = vim.fn.expand "~/.nix-profile/bin",
            extra_args = {
                "--max-line-length", "88", -- Match the line-length of Black.
                "--ignore", "E203,W503" -- Avoid conflict with Black.
            },
            diagnostics_format = diagnostics_msg
        }), null_ls.builtins.diagnostics.mypy.with({ -- Python
            extra_args = {
                "--follow-imports", "silent", "--warn-unreachable", "--strict"
            },
            diagnostics_format = diagnostics_msg
        }), null_ls.builtins.diagnostics.pydocstyle.with({
            diagnostics_format = diagnostics_msg
        }), -- Python
        null_ls.builtins.formatting.clang_format, -- C/C++
        null_ls.builtins.diagnostics.cppcheck.with({
            diagnostics_format = diagnostics_msg
        }), -- C/C++
        null_ls.builtins.formatting.fish_indent, -- Fish
        null_ls.builtins.diagnostics.fish.with({
            diagnostics_format = diagnostics_msg
        }), -- Fish
        null_ls.builtins.formatting.rubocop, -- Ruby
        null_ls.builtins.diagnostics.rubocop.with({
            diagnostics_format = diagnostics_msg
        }), -- Ruby
        null_ls.builtins.formatting.markdownlint.with({ -- Markdown
            extra_args = {"--disable=MD013"}, -- disable LineLength
            diagnostics_format = diagnostics_msg
        }), null_ls.builtins.diagnostics.markdownlint.with({ -- Markdown
            extra_args = {"--disable=MD013"}, -- disable LineLength
            diagnostics_format = diagnostics_msg
        }), null_ls.builtins.formatting.buf, -- Protobuf
        null_ls.builtins.diagnostics.buf.with({
            diagnostics_format = diagnostics_msg
        }), -- Protobuf
        null_ls.builtins.formatting.cmake_format, -- CMAKE
        null_ls.builtins.formatting.jq, -- JSON
        null_ls.builtins.diagnostics.jsonlint.with({
            diagnostics_format = diagnostics_msg
        }), -- JSON
        null_ls.builtins.diagnostics.yamllint.with({
            diagnostics_format = diagnostics_msg
        }), -- YAML
        null_ls.builtins.formatting.lua_format, -- Lua
        null_ls.builtins.diagnostics.selene.with({
            diagnostics_format = diagnostics_msg
        }), -- Lua
        null_ls.builtins.formatting.tidy, -- HTML
        null_ls.builtins.diagnostics.tidy.with({
            diagnostics_format = diagnostics_msg
        }), -- HTML
        null_ls.builtins.diagnostics.checkmake.with({
            diagnostics_format = diagnostics_msg
        }), -- CMake
        null_ls.builtins.diagnostics.hadolint.with({
            diagnostics_format = diagnostics_msg
        }) -- Dockerfile
    }
})

-- luasnip
local luasnip = require("luasnip")
require("luasnip.loaders.from_vscode").lazy_load() -- Load VSCode-like snippets, e.g. from `friendly-snippets`

-- From: https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings#luasnip
local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and
               vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col,
                                                                          col)
                   :match("%s") == nil
end

-- nvim-cmp
vim.opt.completeopt = {"menu", "menuone", "noselect"}
local cmp = require("cmp")
cmp.setup({
    snippet = {expand = function(args) luasnip.lsp_expand(args.body) end},
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered()
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ["<CR>"] = cmp.mapping.confirm({select = false}),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, {"i", "s"}),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, {"i", "s"})
    }),
    sources = cmp.config.sources({{name = "nvim_lsp"}, {name = "luasnip"}},
                                 {{name = "buffer"}, {name = "calc"}}),
    completion = {keyword_length = 3}
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline("/", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {{name = "buffer"}}
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({{name = "path"}}, {{name = "cmdline"}})
})

-- Setup lspconfig.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local lsp_keymap_opts = {noremap = true, silent = true}
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, lsp_keymap_opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, lsp_keymap_opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, lsp_keymap_opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, lsp_keymap_opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
common_on_attach = function(_client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = {noremap = true, silent = true, buffer = bufnr}
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    -- vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    -- vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    -- vim.keymap.set('n', '<space>wl', function()
    --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    -- end, bufopts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set("n", "ge", "lua vim.lsp.diagnostic.goto_next()", bufopts)
    vim.keymap.set("n", "gE", "lua vim.lsp.diagnostic.goto_prev()", bufopts)
    vim.keymap.set("n", "gi", "lua vim.lsp.buf.implementation()", bufopts)
    vim.keymap.set("n", "gl", "lua vim.lsp.diagnostic.show_line_diagnostics()",
                   bufopts)
end

local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp
                                                                     .protocol
                                                                     .make_client_capabilities())
-- Rust
-- https://github.com/numToStr/dotfiles/blob/f972b9ebfd742daac8f2dc5ea6c19681241bd798/neovim/.config/nvim/lua/numToStr/plugins/lsp/servers.lua#L63-L85
require("lspconfig")["rust_analyzer"].setup {
    on_attach = function(client, bufnr) common_on_attach(client, bufnr) end,
    capabilities = capabilities,
    settings = {
        ["rust_analyzer"] = {
            cargo = {allFeatures = false},
            checkOnSave = {allFeatures = false, command = 'clippy'},
            procMacro = {
                enable = true,
                ignored = {
                    ['async-trait'] = {'async_trait'},
                    ['napi-derive'] = {'napi'},
                    ['async-recursion'] = {'async_recursion'}
                }
            }
        }
    }
}
-- Python
require("lspconfig")["pyright"].setup {
    on_attach = function(client, bufnr) common_on_attach(client, bufnr) end,
    capabilities = capabilities
}

-- rust-tools-nvim
-- learning how to configure rust-analyzer directly for now...
-- require('rust-tools').setup({})

-- camelcasemotion
vim.g.camelcasemotion_key = "<leader>"

-- vim.cmd([[
-- augroup configgroup
-- autocmd!
-- autocmd VimEnter * highlight clear SignColumn

-- " Strip trailing whitespace from all files. See the configuration in
-- " plugins.vimrc for a blacklist of filetypes.
-- autocmd BufEnter * EnableStripWhitespaceOnSave

-- " Allow word wrapping for some filetypes.
-- autocmd BufNewFile,BufReadPost *.md set filetype=markdown
-- autocmd FileType markdown setlocal wrap
-- autocmd FileType markdown setlocal conceallevel=0

-- " YAML style is 2-space indenting.
-- autocmd FileType yaml setlocal tabstop=2
-- autocmd FileType yaml setlocal shiftwidth=2
-- autocmd FileType yaml setlocal softtabstop=2
-- autocmd FileType yaml setlocal commentstring=#\ %s

-- " Bash style is 2-space indenting.
-- autocmd FileType sh setlocal tabstop=2
-- autocmd FileType sh setlocal shiftwidth=2
-- autocmd FileType sh setlocal softtabstop=2
-- autocmd FileType sh setlocal commentstring=#\ %s

-- " Ruby style is 2-space indenting.
-- autocmd FileType ruby setlocal tabstop=2
-- autocmd FileType ruby setlocal shiftwidth=2
-- autocmd FileType ruby setlocal softtabstop=2
-- autocmd FileType ruby setlocal commentstring=#\ %s

-- autocmd FileType python setlocal commentstring=#\ %s

-- " Map unknown files to known filetypes.
-- autocmd BufEnter *.cls setlocal filetype=java
-- autocmd BufEnter *.zsh-theme setlocal filetype=zsh
-- autocmd BufEnter *.launch setlocal filetype=xml " ROS .launch files are XML
-- autocmd BufEnter *.bats set filetype=sh

-- " Makefiles need to keep their tabs.
-- autocmd BufEnter Makefile setlocal noexpandtab
-- augroup END
-- ]])

-- vim.cmd("filetype plugin indent on")
-- vim.cmd("syntax enable")

-- Restore cursor style on exit.
vim.cmd("au VimLeave * set guicursor=a:hor25-blinkon0")

-- Make Y yank everything from the cursor to the end of the line. This makes Y
-- act more like C or D because by default, Y yanks the current line (i.e. the
-- same as yy).
vim.keymap
    .set("", "Y", "y$", {desc = "Yank from cursor to the end of the line"})

-- Turn off the search highlight.
vim.keymap.set("n", "<leader><space>", ":nohlsearch<CR>",
               {desc = "Turn off the search highlight"})

-- Map ctrl-h/j/k/l to move between split windows.
vim.keymap
    .set("", "<c-h>", "<c-w>j<c-w>_", {desc = "Move left to window split"})
vim.keymap
    .set("", "<c-j>", "<c-w>j<c-w>_", {desc = "Move down to window split"})
vim.keymap.set("", "<c-k>", "<c-w>k<c-w>_", {desc = "Move up to window split"})
vim.keymap.set("", "<c-l>", "<c-w>l<c-w>_",
               {desc = "Move right to window split"})

-- Delete a selection w/o updating the buffer.
vim.keymap.set("v", "x", '"_x',
               {desc = "Delete (d) without updating the buffer"})
vim.keymap.set("v", "X", '"_X',
               {desc = "Delete (D) without updating the buffer"})

-- Toggle 'slf/gundo.vim'
vim.keymap.set("n", "<leader>u", ":GundoToggle<CR>",
               {desc = "Toggle 'Gundo' plugin"})

-- Move up/down over wrapped lines in a nice manner.
vim.keymap.set("", "j", "(v:count == 0 ? 'gj' : 'j')",
               {expr = true, silent = true})
vim.keymap.set("", "k", "(v:count == 0 ? 'gk' : 'k')",
               {expr = true, silent = true})
