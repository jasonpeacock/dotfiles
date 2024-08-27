require("solarized").setup({
	-- theme = 'neo' -- or comment to use solarized default theme.
})
vim.cmd("colorscheme solarized")

-- Load a local Neovim config for rapid prototyping, avoid
-- having to rebuild home-manager for every change.
vim.cmd("source ~/.config/nvim/local.lua")
