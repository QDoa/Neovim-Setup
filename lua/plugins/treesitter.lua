return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        build = ':TSUpdate',
        -- config = function ()
        --     local configs = require("nvim-treesitter.configs")
        --
        --     configs.setup({
        --         ensure_installed = {
        --             "c", "python", "lua", "vimdoc", "cpp", "javascript", "typescript", "tsx", "css", "cpp", "json", "bash"
        --         },
        --         sync_install = false,
        --         auto_install = true,
        --         highlight = { enable = true },
        --         indent = { enable = true },
        --         ignore_install = {},
        --     })
        -- end
    },
    {'nvim-treesitter/nvim-treesitter-context'},
}
