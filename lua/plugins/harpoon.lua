return {
    'theprimeagen/harpoon',
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    keys = {
        {'<leader>a', ':lua require("harpoon.mark").add_file()<cr>', mode = 'n'},
        {'<C-e>', ':lua require("harpoon.ui").toggle_quick_menu()<cr>', mode = 'n'},
    },
}
