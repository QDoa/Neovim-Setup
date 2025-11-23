
return {
    {
        'nvim-telescope/telescope.nvim', tag = '0.1.6',
        -- or                              , branch = '0.1.x',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function ()
            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
            vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
            vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
            vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

        end
    },
    {
        'numToStr/Comment.nvim', opts = {},
    },
    {
        'saghen/blink.pairs',
        version = '*', -- (recommended) only required with prebuilt binaries

        -- download prebuilt binaries from github releases
        dependencies = 'saghen/blink.download',

        --- @module 'blink.pairs'
        --- @type blink.pairs.Config
        opts = {
            mappings = {
                -- you can call require("blink.pairs.mappings").enable() and require("blink.pairs.mappings").disable() to enable/disable mappings at runtime
                enabled = true,
                -- see the defaults: https://github.com/Saghen/blink.pairs/blob/main/lua/blink/pairs/config/mappings.lua#L10
                pairs = {},
            },
            highlights = {
                enabled = true,
                groups = {
                    'BlinkPairsOrange',
                    'BlinkPairsPurple',
                    'BlinkPairsBlue',
                },
                matchparen = {
                    enabled = true,
                    group = 'MatchParen',
                },
            },
            debug = false,
        }
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        opts = {
            options = {
                diagnostic = 'nvim_lsp',
            },
            sections = {
                lualine_c = {
                    { "filename" },
                    {
                        "navic",
                        color_correction = "dynamic",
                    },
                }
            },
        },
    },
    {
        'akinsho/bufferline.nvim',
        version = "*",
        dependencies = 'nvim-tree/nvim-web-devicons',
        opts = {
            options = {
                diagnostic = "nvim_lsp",
                mode = "tabs",
            }
        }
    },
    {
        "SmiteshP/nvim-navic",
        dependencies = { "neovim/nvim-lspconfig" },
        lazy = true,
        opts = {
            highlight = true,
            depth = 5,
            lsp = {
                auto_attach = true,
                preference = {
                    "ruff",
                }
            }
        }
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {},
    },
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        },
        config = function ()
            require("todo-comments").setup{}
            vim.keymap.set("n", "]t", function()
                require("todo-comments").jump_next()
            end, { desc = "Next todo comment" })

            vim.keymap.set("n", "[t", function()
                require("todo-comments").jump_prev()
            end, { desc = "Previous todo comment" })
        end
    },
    {
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end
    },
    {
        'folke/trouble.nvim',
        dependencies  = 'nvim-tree/nvim-web-devicons',
        config = function ()
            require("trouble").setup {

            }
        end
    },
    {"tpope/vim-dadbod"},
    {"kristijanhusak/vim-dadbod-ui"},
    {"kristijanhusak/vim-dadbod-completion"},
    {"preservim/tagbar"},
}

