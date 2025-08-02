return {
    {
        "nvim-neotest/neotest-python",
    },
    {
        "nvim-neotest/neotest",
        dependencies = {
            "nvim-neotest/nvim-nio",
            "nvim-lua/plenary.nvim",
            "antoinemadec/FixCursorHold.nvim",
            "nvim-treesitter/nvim-treesitter",
            "nvim-neotest/neotest-python",
        },
        opts = {
            adapters = {
                ["neotest-python"] = {
                    runner = "pytest"
                }
            }
        }
    },
}
