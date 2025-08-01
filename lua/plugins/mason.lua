return {
    {
        'mason-org/mason.nvim',
        config = true,
    },
    {
        'williamboman/mason-lspconfig.nvim',
        dependencies = {
            { "mason-org/mason.nvim", opts = {} },
            "neovim/nvim-lspconfig",
        },
        opts = {
            ensure_installed = {'lua_ls', 'pyright', 'ruff', 'jsonls'},
        }
    },
}
