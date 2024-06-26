-- vim-better-whitespace
vim.g.better_whitespace_enabled = 1
vim.g.better_whitespace_filetypes_blacklist = { "diff", "gitcommit", "git", "help" }
vim.g.show_spaces_that_precede_tabs = 1
vim.g.strip_whitelines_at_eof = 1
vim.g.strip_whitespace_confirm = 0
vim.g.strip_whitespace_on_save = 1

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

require('fidget').setup {}

require('nvim-treesitter.configs').setup {
    ensure_installed = {},
    sync_install = false,
    ignore_install = {},
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

-- Call async format before save & exiting.
-- https://github.com/lukas-reineke/lsp-format.nvim
vim.cmd("cabbrev wq execute \"Format sync\" <bar> wq")

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
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, keymap_opts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, keymap_opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, keymap_opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, keymap_opts)
    vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, keymap_opts)
    vim.keymap.set("n", "g0", vim.lsp.buf.document_symbol, keymap_opts)
    vim.keymap.set("n", "gW", vim.lsp.buf.workspace_symbol, keymap_opts)
    vim.keymap.set("n", "ga", vim.lsp.buf.code_action, keymap_opts)
    vim.keymap.set('n', 'gf', function() vim.lsp.buf.format { async = true } end, keymap_opts)
    vim.keymap.set('n', 'rn', vim.lsp.buf.rename, keymap_opts)
    -- These match the new Neovim 0.10 defaults
    vim.keymap.set("n", "K", vim.lsp.buf.hover, keymap_opts)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, keymap_opts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, keymap_opts)
    vim.keymap.set("n", "<C-W>d", vim.diagnostic.open_float, keymap_opts)

    -- Show diagnostic popup on cursor hover
    -- local diag_float_grp = vim.api.nvim_create_augroup("DiagnosticFloat", { clear = true })
    -- vim.api.nvim_create_autocmd("CursorHold", {
    --     callback = function()
    --         vim.diagnostic.open_float(nil, { focusable = false })
    --     end,
    --     group = diag_float_grp,
    -- })
end

-- Show the error code with the error message in `bashls` (and other LSPs?).
-- https://github.com/bash-lsp/bash-language-server/issues/752
local diagnostic_format = function(d)
    -- Remove any `[code-123]` within the message, because we're already printing it with `d.code`.
    local message = d.message
    -- Not needed, disabled `diagnostics_format/diagnostics_msg` instead.
    -- message = message:gsub("%b[]", "")

    return string.format("(%s) %s", d.code, message)
end
vim.diagnostic.config({
    virtual_text = {
        format = diagnostic_format,
    },
    float = {
        format = diagnostic_format,
    }
})

-- Bash
-- Configured via env vars in `loginShellInit.fish`
require('lspconfig')['bashls'].setup {
    -- capabilities = capabilities,
    on_attach = common_on_attach
}

-- Python
-- Using Ruff instead of Flake8/PyCodeStyle.
-- Use line length of 88 to match Black's default.
require('lspconfig')['pylsp'].setup {
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

-- Rust
vim.g.rustaceanvim = {
    -- Plugin configuration
    tools = {
    },
    -- LSP configuration
    server = {
        on_attach = common_on_attach,
        default_settings = {
            -- rust-analyzer language server configuration
            ['rust-analyzer'] = {
                checkOnSave = {
                    command = "clippy",
                },
            },
        },
    },
    -- DAP configuration
    dap = {
    },
}

-- Nix
require('lspconfig')['nil_ls'].setup {
    -- capabilities = capabilities,
    on_attach = common_on_attach
}

-- Typescript/Javascript
require('lspconfig')['eslint'].setup {
    -- capabilities = capabilities,
    on_attach = common_on_attach
}

-- Lua
require('lspconfig')['lua_ls'].setup {
    -- capabilities = capabilities,
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
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local diagnostics_msg = "[#{c}] #{m} (#{s})"
local null_ls = require("null-ls")
null_ls.setup({
    -- diagnostics_format = diagnostics_msg,
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
    sources = {
        require("none-ls.formatting.trim_newlines").with({
            -- use their specific formatters
            disabled_filetypes = {
                "rust", "python", "bash", "nix", "ruby", "markdown"
            }
        }),
        require("none-ls.formatting.trim_whitespace").with({
            -- use their specific formatters
            disabled_filetypes = {
                "rust", "python", "bash", "nix", "ruby", "markdown"
            }
        }),
        null_ls.builtins.formatting.shfmt.with({ -- Bash
            extra_args = {
                "--indent", "2",
                "--case-indent",
                "--space-redirects",
                "--keep-padding" },
            -- diagnostics_format = diagnostics_msg
        }),
        null_ls.builtins.diagnostics.hadolint.with({ -- Dockerfile
            -- diagnostics_format = diagnostics_msg
        }),
        null_ls.builtins.diagnostics.markdownlint_cli2.with({ -- Markdown
            args = { "$FILENAME" },
            -- extra_args = { "--disable MD013 MD046 --" },
            -- diagnostics_format = diagnostics_msg
        }),
        null_ls.builtins.diagnostics.gitlint.with({
            -- diagnostics_format = diagnostics_msg
        }),
        null_ls.builtins.formatting.fish_indent,
        null_ls.builtins.diagnostics.fish.with({
            -- diagnostics_format = diagnostics_msg
        }),
        -- null_ls.builtins.formatting.rubocop,
        -- null_ls.builtins.diagnostics.rubocop.with({
        --     diagnostics_format = diagnostics_msg
        -- })
        --         null_ls.builtins.formatting.rustfmt
        --         .with({extra_args = {"--edition=2021"}}),
        --         null_ls.builtins.code_actions.eslint_d,
        --         null_ls.builtins.formatting.eslint_d,
        --         null_ls.builtins.diagnostics.eslint_d.with({
        --             diagnostics_format = diagnostics_msg
        --         }),
        --         null_ls.builtins.code_actions.refactoring,
        --         null_ls.builtins.completion.tags,
        --         null_ls.builtins.code_actions.statix,
        --         null_ls.builtins.formatting.alejandra,
        --         null_ls.builtins.diagnostics.deadnix.with({
        --             diagnostics_format = diagnostics_msg
        --         }),
        --         null_ls.builtins.diagnostics.statix.with({
        --             diagnostics_format = diagnostics_msg
        --         }),
        --         null_ls.builtins.formatting.black,
        --         null_ls.builtins.diagnostics.flake8.with({
        --             -- only_local = vim.fn.expand "~/.nix-profile/bin",
        --             extra_args = {
        --                 "--max-line-length", "88", -- Match the line-length of Black.
        --                 "--ignore", "E203,W503" -- Avoid conflict with Black.
        --             },
        --             diagnostics_format = diagnostics_msg
        --         }),
        --         null_ls.builtins.diagnostics.mypy.with({
        --             extra_args = {
        --                 "--follow-imports", "silent", "--warn-unreachable", "--strict"
        --             },
        --             diagnostics_format = diagnostics_msg
        --         }),
        --         null_ls.builtins.diagnostics.pydocstyle.with({
        --             diagnostics_format = diagnostics_msg
        --         }),
        --         null_ls.builtins.formatting.clang_format,
        --         null_ls.builtins.diagnostics.cppcheck.with({
        --             extra_args = {"--language", "c++"},
        --             diagnostics_format = diagnostics_msg
        --         }),
        --         null_ls.builtins.formatting.buf,
        --         null_ls.builtins.diagnostics.buf.with({
        --             diagnostics_format = diagnostics_msg
        --         }),
        --         null_ls.builtins.formatting.cmake_format,
        --         null_ls.builtins.formatting.jq,
        --         null_ls.builtins.diagnostics.jsonlint.with({
        --             diagnostics_format = diagnostics_msg
        --         }),
        --         null_ls.builtins.diagnostics.yamllint.with({
        --             diagnostics_format = diagnostics_msg
        --         }),
        --         null_ls.builtins.formatting.lua_format,
        --         null_ls.builtins.diagnostics.selene.with({
        --             diagnostics_format = diagnostics_msg
        --         }),
        --         null_ls.builtins.formatting.tidy,
        --         null_ls.builtins.diagnostics.tidy.with({
        --             diagnostics_format = diagnostics_msg
        --         }),
        --         null_ls.builtins.diagnostics.checkmake.with({
        --             diagnostics_format = diagnostics_msg
        --         }),
    }
})

-- Completion stuff, disabled for now...

-- -- Set completeopt to have a better completion experience
-- -- :help completeopt
-- -- menuone: popup even when there's only one match
-- -- noinsert: Do not insert text until a selection is made
-- -- noselect: Do not auto-select, nvim-cmp plugin will handle this for us.
-- vim.opt.completeopt = "menuone,noinsert,noselect"
-- -- Avoid showing extra messages when using completion
-- vim.opt.shortmess = vim.opt.shortmess + "c"

-- -- Toggle 'slf/gundo.vim'
-- vim.keymap.set("n", "<leader>u", ":GundoToggle<CR>",
--     { desc = "Toggle 'Gundo' plugin" })

-- local luasnip = require("luasnip")
-- -- Load VSCode-like snippets, e.g. from `friendly-snippets`
-- require("luasnip.loaders.from_vscode").lazy_load()

-- -- See https://github.com/hrsh7th/nvim-cmp#basic-configuration
-- local has_words_before = function()
--     unpack = unpack or table.unpack
--     local line, col = unpack(vim.api.nvim_win_get_cursor(0))
--     return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
-- end
-- local cmp = require("cmp")
-- cmp.setup({
--     preselect = cmp.PreselectMode.None,
--     window = {
--         completion = cmp.config.window.bordered(),
--         documentation = cmp.config.window.bordered()
--     },
--     snippet = {
--         expand = function(args)
--             require('luasnip').lsp_expand(args.body)
--         end,
--     },
--     mapping = {
--         ["<C-p>"] = cmp.mapping.select_prev_item(),
--         ["<C-n>"] = cmp.mapping.select_next_item(),
--         -- ["<S-Tab>"] = cmp.mapping.select_prev_item(),
--         -- ["<Tab>"] = cmp.mapping.select_next_item(),
--         ["<C-d>"] = cmp.mapping.scroll_docs(-4),
--         ["<C-f>"] = cmp.mapping.scroll_docs(4),
--         ["<C-Space>"] = cmp.mapping.complete(),
--         ["<C-e>"] = cmp.mapping.close(),
--         ["<CR>"] = cmp.mapping.confirm({
--             behavior = cmp.ConfirmBehavior.Insert,
--             select = true,
--         }),
--         ["<Tab>"] = cmp.mapping(function(fallback)
--             if cmp.visible() then
--                 cmp.select_next_item()
--             elseif luasnip.expand_or_jumpable() then
--                 luasnip.expand_or_jump()
--             elseif has_words_before() then
--                 cmp.complete()
--             else
--                 fallback()
--             end
--         end, { "i", "s" }),
--         ["<S-Tab>"] = cmp.mapping(function(fallback)
--             if cmp.visible() then
--                 cmp.select_prev_item()
--             elseif luasnip.jumpable(-1) then
--                 luasnip.jump(-1)
--             else
--                 fallback()
--             end
--         end, { "i", "s" }),
--     },
--     sources = {
--         { name = "nvim_lsp" },
--         { name = "luasnip" },
--         { name = "path" },
--         { name = "buffer" },
--     },
--     completion = { keyword_length = 3 },
-- })

-- -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
-- cmp.setup.cmdline('/', {
--     mapping = cmp.mapping.preset.cmdline(),
--     sources = {
--         { name = 'buffer' }
--     }
-- })

-- -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
-- cmp.setup.cmdline(':', {
--     mapping = cmp.mapping.preset.cmdline(),
--     sources = cmp.config.sources({
--         { name = 'path' }
--     }, {
--         {
--             name = 'cmdline',
--             option = {
--                 ignore_cmds = { 'Man', '!' }
--             }
--         }
--     })
-- })

-- -- Setup lspconfig.
-- local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
