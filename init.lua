require("setting")
require("config.lazy")
require("keymap")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup(
    "plugins"
)

-- require("keymap")

local neogit = require('neogit')
neogit.setup {}

local treesitter_context = require("treesitter-context")
-- treesitter_context.setup {}
treesitter_context.enable()
vim.opt.signcolumn = 'yes'

-- local lspconfig_defaults = require('lspconfig').util.default_config
-- lspconfig_defaults.capabilities = vim.tbl_deep_extend(
--     'force',
--     lspconfig_defaults.capabilities,
--     require('cmp_nvim_lsp').default_capabilities()
-- )

require('mason-lspconfig').setup({
    ensure_installed = {'lua_ls', 'pyright', 'ruff', 'jsonls', 'clangd', 'cssls', 'tailwindcss', 'ts_ls', 'eslint'},
})

local harpoon = require('harpoon')
harpoon:setup({})
vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

