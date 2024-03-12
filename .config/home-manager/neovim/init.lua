-- Lua configuration for Neovim
-- # selene: allow(undefined_variable, unscoped_variables)
-- Use spacebar for leader key, instead of '\'.
vim.g.mapleader = " "

vim.opt.autoindent = true -- Always enable auto-indenting.
-- vim.opt.wrap = false                  -- Stop word wrapping.
-- vim.opt.scrolloff = 1                 -- Space above cursor from screen edge.
-- vim.opt.sidescrolloff = 5             -- Space beside cursor from screen edge.
-- vim.opt.cursorcolumn = true           -- Highlight the current column.
-- vim.opt.cursorline = true             -- Highlight the current line.
-- vim.opt.conceallevel = 0              -- Don't hide characters.
vim.opt.encoding = "utf8"  -- Set standard file encoding.
vim.opt.mouse = "a"        -- Enable the mouse.
vim.opt.backup = false     -- Don't keep a backup file
vim.opt.errorbells = false -- Be quiet.
vim.opt.swapfile = false   -- Don't use swap files.
vim.opt.showmatch = true   -- Show matching brackets.
vim.opt.updatetime = 100   -- Write to swap file faster, and makes vim-gitgutter more responsive
vim.opt.undolevels = 100   -- Adjust system undo levels.
vim.opt.wmh = 0            -- Set smallest possible window when minimizing a split window.
vim.opt.number = true      -- Turn on line numbers.
-- vim.opt.relativenumber = true         -- Show the line numbers as relative.

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
vim.opt.foldenable = false
-- vim.opt.foldcolumn = 2                -- Reserve space for the fold.
-- vim.opt.foldlevelstart = 99 -- All folds are open by default.
-- vim.opt.foldmethod = "indent"           -- Use indenting to determine folds.
-- vim.opt.foldmethod = syntax           -- Use syntax rules to determine folds.
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

-- Searching.
vim.opt.hlsearch = true   -- Use search highlighting.
vim.opt.ignorecase = true -- Do case insensitive searching.
vim.opt.incsearch = true  -- Perform incremental searching.
vim.opt.smartcase = true  -- Ignore case unless case is used.

-- Put the Git signs/LSP diagnostics/etc into the number column,
-- stop all the sideways jumping around.
vim.opt.signcolumn = "number"

-- Set completeopt to have a better completion experience
-- :help completeopt
-- menuone: popup even when there's only one match
-- noinsert: Do not insert text until a selection is made
-- noselect: Do not auto-select, nvim-cmp plugin will handle this for us.
vim.opt.completeopt = "menuone,noinsert,noselect"
-- Avoid showing extra messages when using completion
vim.opt.shortmess = vim.opt.shortmess + "c"

-- Fix grey background in Vim for dracula
-- https://github.com/dracula/vim/issues/96
--vim.g.dracula_colorterm = 0

-- Use GUI-based colors even when run within a terminal,
-- this pushes VIM to support truecolors and fixes the
-- grey background in the Dracula theme
--vim.opt.termguicolors = true

-- vim.cmd("colorscheme dracula")
-- vim.cmd("colorscheme nord")
--
vim.g.solarized_italic_comments = true
vim.g.solarized_italic_keywords = false
vim.g.solarized_italic_functions = false
vim.g.solarized_italic_variables = false
vim.g.solarized_contrast = true
vim.g.solarized_borders = false
vim.g.solarized_disable_background = false
require('solarized').set()

vim.opt.background = "dark"


-- https://stackoverflow.com/questions/3494435/vimrc-make-comments-italic
-- https://stackoverflow.com/questions/5830125/how-to-change-font-color-for-comments-in-vim
-- https://upload.wikimedia.org/wikipedia/commons/1/15/Xterm_256color_chart.svg
vim.cmd("highlight Comment cterm=italic ctermfg=225")

vim.g.airline_powerline_fonts = 1
-- vim.g.airline_theme = "dracula"
vim.g.airline_theme = "nord"

-- vim-better-whitespace
vim.g.better_whitespace_filetypes_blacklist = { "diff", "gitcommit" } -- Filetypes to skip stripping of whitespace.
vim.g.strip_whitelines_at_eof = 1
vim.g.show_spaces_that_precede_tabs = 1
vim.g.strip_whitespace_confirm = 0
vim.g.strip_whitespace_on_save = 1

-- camelcasemotion
vim.g.camelcasemotion_key = "<leader>"

-- Call async format before save & exiting.
-- https://github.com/lukas-reineke/lsp-format.nvim
vim.cmd("cabbrev wq execute \"Format sync\" <bar> wq")

-- Restore cursor style on exit.
vim.cmd("au VimLeave * set guicursor=a:hor25-blinkon0")

-- Make Y yank everything from the cursor to the end of the line. This makes Y
-- act more like C or D because by default, Y yanks the current line (i.e. the
-- same as yy).
vim.keymap
    .set("", "Y", "y$", { desc = "Yank from cursor to the end of the line" })

-- Turn off the search highlight.
vim.keymap.set("n", "<leader><space>", ":nohlsearch<CR>",
    { desc = "Turn off the search highlight" })

-- Map ctrl-h/j/k/l to move between split windows.
vim.keymap
    .set("", "<c-h>", "<c-w>j<c-w>_", { desc = "Move left to window split" })
vim.keymap
    .set("", "<c-j>", "<c-w>j<c-w>_", { desc = "Move down to window split" })
vim.keymap.set("", "<c-k>", "<c-w>k<c-w>_", { desc = "Move up to window split" })
vim.keymap.set("", "<c-l>", "<c-w>l<c-w>_",
    { desc = "Move right to window split" })

-- Delete a selection w/o updating the buffer.
vim.keymap.set("v", "x", '"_x',
    { desc = "Delete (d) without updating the buffer" })
vim.keymap.set("v", "X", '"_X',
    { desc = "Delete (D) without updating the buffer" })

-- Toggle 'slf/gundo.vim'
vim.keymap.set("n", "<leader>u", ":GundoToggle<CR>",
    { desc = "Toggle 'Gundo' plugin" })

-- Move up/down over wrapped lines in a nice manner.
vim.keymap.set("", "j", "(v:count == 0 ? 'gj' : 'j')",
    { expr = true, silent = true })
vim.keymap.set("", "k", "(v:count == 0 ? 'gk' : 'k')",
    { expr = true, silent = true })

require("ibl").setup {
}

require('gitsigns').setup { signcolumn = true }

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

local luasnip = require("luasnip")
-- Load VSCode-like snippets, e.g. from `friendly-snippets`
require("luasnip.loaders.from_vscode").lazy_load()

-- See https://github.com/hrsh7th/nvim-cmp#basic-configuration
local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end
local cmp = require("cmp")
cmp.setup({
    preselect = cmp.PreselectMode.None,
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered()
    },
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    mapping = {
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        -- ["<S-Tab>"] = cmp.mapping.select_prev_item(),
        -- ["<Tab>"] = cmp.mapping.select_next_item(),
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.close(),
        ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
        }),
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
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    },
    sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "path" },
        { name = "buffer" },
    },
    completion = { keyword_length = 3 },
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
        {
            name = 'cmdline',
            option = {
                ignore_cmds = { 'Man', '!' }
            }
        }
    })
})

-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

require('fidget').setup {}

require('lsp-format').setup {
    bash = { tab_width = 2 },
    yaml = { tab_width = 2 },
}

-- Use a common on_attach function to only map the following keys
-- after the language server attaches to the current buffer.
local common_on_attach = function(client, bufnr)
    require('lsp-format').on_attach(client)

    local keymap_opts = { noremap = true, silent = true, buffer = bufnr }

    -- Code navigation and shortcuts
    -- vim.keymap.set("n", "<C-K>", vim.lsp.buf.signature_help, keymap_opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, keymap_opts)
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, keymap_opts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, keymap_opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, keymap_opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, keymap_opts)
    vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, keymap_opts)
    vim.keymap.set("n", "g0", vim.lsp.buf.document_symbol, keymap_opts)
    vim.keymap.set("n", "gW", vim.lsp.buf.workspace_symbol, keymap_opts)
    vim.keymap.set("n", "ga", vim.lsp.buf.code_action, keymap_opts)
    vim.keymap.set("n", "g[", vim.diagnostic.goto_prev, keymap_opts)
    vim.keymap.set("n", "g]", vim.diagnostic.goto_next, keymap_opts)
    vim.keymap.set('n', 'gf', function() vim.lsp.buf.format { async = true } end, keymap_opts)
    vim.keymap.set('n', 'rn', vim.lsp.buf.rename, keymap_opts)

    -- Show diagnostic popup on cursor hover
    -- local diag_float_grp = vim.api.nvim_create_augroup("DiagnosticFloat", { clear = true })
    -- vim.api.nvim_create_autocmd("CursorHold", {
    --     callback = function()
    --         vim.diagnostic.open_float(nil, { focusable = false })
    --     end,
    --     group = diag_float_grp,
    -- })
end

-- Bash
require('lspconfig')['bashls'].setup {
    capabilities = capabilities,
    on_attach = common_on_attach
}

-- Nix
require('lspconfig')['nil_ls'].setup {
    capabilities = capabilities,
    on_attach = common_on_attach
}

-- Typescript/Javascript
require('lspconfig')['eslint'].setup {
    capabilities = capabilities,
    on_attach = common_on_attach
}

-- Rust
-- Configure LSP through rust-tools.nvim plugin.
-- `rust-tools` will configure and enable certain LSP features for us.
-- See: https://github.com/simrat39/rust-tools.nvim#configuration
require('rust-tools').setup({
    tools = {
        runnables = {
            use_telescope = true,
        },
        inlay_hints = {
            auto = true,
            show_parameter_hints = false,
            parameter_hints_prefix = "",
            other_hints_prefix = "",
        },
    },
    -- All the opts to send to nvim-lspconfig, these override the defaults
    -- set by `rust-tools.nvim`.
    -- See: https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rust_analyzer
    server = {
        capabilities = capabilities,
        on_attach = common_on_attach,
        settings = {
            -- To enable rust-analyzer settings, see:
            -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
            ["rust-analyzer"] = {
                checkOnSave = {
                    command = "clippy",
                },
            },
        },
    },
})

-- Rust
-- https://github.com/numToStr/dotfiles/blob/f972b9ebfd742daac8f2dc5ea6c19681241bd798/neovim/.config/nvim/lua/numToStr/plugins/lsp/servers.lua#L63-L85
-- require("lspconfig")["rust_analyzer"].setup {
--     on_attach = common_on_attach,
--     capabilities = capabilities,
--     settings = {
--         ["rust_analyzer"] = {
--             cargo = {allFeatures = false},
--             checkOnSave = {allFeatures = false, command = 'clippy'},
--             procMacro = {
--                 enable = true,
--                 ignored = {
--                     ['async-trait'] = {'async_trait'},
--                     ['napi-derive'] = {'napi'},
--                     ['async-recursion'] = {'async_recursion'}
--                 }
--             }
--         }
--     }
-- }

-- Lua
require('lspconfig')['lua_ls'].setup {
    capabilities = capabilities,
    on_attach = common_on_attach,
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { 'vim' },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
                -- For message: "Do you need to configure your environment as luassert"
                -- https://github.com/sumneko/lua-language-server/discussions/1688
                checkThirdParty = false,
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    },
}

-- Python
-- Using Ruff instead of Flake8/PyCodeStyle.
-- Use line length of 88 to match Black's default.
require('lspconfig')['pylsp'].setup {
    capabilities = capabilities,
    on_attach = common_on_attach,
    settings = {
        pylsp = {
            -- https://github.com/python-lsp/python-lsp-server/blob/develop/CONFIGURATION.md
            plugins = {
                autopep8 = {
                    enabled = false,
                },
                mccade = {
                    enabled = false,
                },
                pycodestyle = {
                    enabled = false,
                },
                pyflakes = {
                    enabled = false,
                },
                yapf = {
                    enabled = false,
                },
                mypy = {
                    enabled = true,
                },
                ruff = {
                    -- https://github.com/python-lsp/python-lsp-ruff
                    enabled = true, -- default
                    lineLength = 88,
                },
                black = {
                    -- https://github.com/python-lsp/python-lsp-black
                    enabled = true,
                    line_length = 88, -- default
                },
            },
        },
    },
}

-- nvim-treesitter
-- https://github.com/nvim-treesitter/nvim-treesitter
require('nvim-treesitter.configs').setup {
    -- Automatically install missing parsers when entering buffer
    -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
    auto_install = false,
    -- Grammars are installed via `neovim.nix` so that they
    -- are compiled correctly for Nix. Otherwise you get an
    -- error from `dlopen` about not being able to find `stdlibc.6.so`.
    highlight = {
        enable = true,
        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        -- additional_vim_regex_highlighting = {"python"}
        additional_vim_regex_highlighting = false,
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
    --indent = {enable = true, disable = {"python"}}
    indent = { enable = true }
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
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
                    vim.lsp.buf.format()
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
        -- }), null_ls.builtins.formatting.markdownlint_cli2.with({
        --     -- extra_args = { "--disable MD013 MD046 --" },
        --     diagnostics_format = diagnostics_msg
    }), null_ls.builtins.diagnostics.markdownlint_cli2.with({
        args = { "$FILENAME" },
        -- extra_args = { "--disable MD013 MD046 --" },
        diagnostics_format = diagnostics_msg
    }), null_ls.builtins.diagnostics.hadolint.with({
        diagnostics_format = diagnostics_msg
    })
        --         null_ls.builtins.formatting.rustfmt
        --         .with({extra_args = {"--edition=2021"}}),
        --         null_ls.builtins.code_actions.gitsigns,
        --         null_ls.builtins.diagnostics.gitlint.with({
        --             diagnostics_format = diagnostics_msg
        --         }), null_ls.builtins.code_actions.eslint_d,
        --         null_ls.builtins.formatting.eslint_d,
        --         null_ls.builtins.diagnostics.eslint_d.with({
        --             diagnostics_format = diagnostics_msg
        --         }), null_ls.builtins.code_actions.refactoring,
        --         null_ls.builtins.completion.tags,
        --         null_ls.builtins.code_actions.shellcheck,
        --         null_ls.builtins.formatting.shfmt.with({
        --             extra_args = {"-i", "2", "-ci", "-sr"}, -- Make shfmt pretty.
        --             diagnostics_format = diagnostics_msg
        --         }), null_ls.builtins.diagnostics.shellcheck.with({
        --             extra_args = {"-s", "bash", "-e", "SC1008"} -- Force shellcheck to always assume Bash,
        --             -- and ignore warning about unsupported #!.
        --         }), null_ls.builtins.code_actions.statix,
        --         null_ls.builtins.formatting.alejandra,
        --         null_ls.builtins.diagnostics.deadnix.with({
        --             diagnostics_format = diagnostics_msg
        --         }), null_ls.builtins.diagnostics.statix.with({
        --             diagnostics_format = diagnostics_msg
        --         }), null_ls.builtins.formatting.black,
        --         null_ls.builtins.diagnostics.flake8.with({
        --             -- only_local = vim.fn.expand "~/.nix-profile/bin",
        --             extra_args = {
        --                 "--max-line-length", "88", -- Match the line-length of Black.
        --                 "--ignore", "E203,W503" -- Avoid conflict with Black.
        --             },
        --             diagnostics_format = diagnostics_msg
        --         }), null_ls.builtins.diagnostics.mypy.with({
        --             extra_args = {
        --                 "--follow-imports", "silent", "--warn-unreachable", "--strict"
        --             },
        --             diagnostics_format = diagnostics_msg
        --         }), null_ls.builtins.diagnostics.pydocstyle.with({
        --             diagnostics_format = diagnostics_msg
        --         }), null_ls.builtins.formatting.clang_format,
        --         null_ls.builtins.diagnostics.cppcheck.with({
        --             extra_args = {"--language", "c++"},
        --             diagnostics_format = diagnostics_msg
        --         }), null_ls.builtins.formatting.fish_indent,
        --         null_ls.builtins.diagnostics.fish.with({
        --             diagnostics_format = diagnostics_msg
        --         }), null_ls.builtins.formatting.rubocop,
        --         null_ls.builtins.diagnostics.rubocop.with({
        --             diagnostics_format = diagnostics_msg
        --         }), null_ls.builtins.formatting.buf,
        --         null_ls.builtins.diagnostics.buf.with({
        --             diagnostics_format = diagnostics_msg
        --         }), null_ls.builtins.formatting.cmake_format,
        --         null_ls.builtins.formatting.jq,
        --         null_ls.builtins.diagnostics.jsonlint.with({
        --             diagnostics_format = diagnostics_msg
        --         }), null_ls.builtins.diagnostics.yamllint.with({
        --             diagnostics_format = diagnostics_msg
        --         }), null_ls.builtins.formatting.lua_format,
        --         null_ls.builtins.diagnostics.selene.with({
        --             diagnostics_format = diagnostics_msg
        --         }), null_ls.builtins.formatting.tidy,
        --         null_ls.builtins.diagnostics.tidy.with({
        --             diagnostics_format = diagnostics_msg
        --         }), null_ls.builtins.diagnostics.checkmake.with({
        --             diagnostics_format = diagnostics_msg
        --         }),
    }
})
