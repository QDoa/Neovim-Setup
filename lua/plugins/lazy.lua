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
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        ---@module "ibl"
        ---@type ibl.config
        opts = {},
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
    {"tpope/vim-dadbod"},
    {"kristijanhusak/vim-dadbod-ui"},
    {"kristijanhusak/vim-dadbod-completion"},
    -- {"preservim/tagbar"},
    {"RRethy/vim-illuminate"},
    {
        "hedyhli/outline.nvim",
        config = function()
            -- Example mapping to toggle outline
            vim.keymap.set("n", "<leader>o", "<cmd>Outline<CR>",
                { desc = "Toggle Outline" })

            require("outline").setup {
                -- Your setup opts here (leave empty to use defaults)
            }
        end,
    },
}
-- {
--     "kylechui/nvim-surround",
--     version = "*", -- Use for stability; omit to use `main` branch for the latest features
--     event = "VeryLazy",
--     config = function()
--         require("nvim-surround").setup({
    --             -- Configuration here, or leave empty to use defaults
    --         })
    --     end
    -- },
    -- {
    --     'folke/trouble.nvim',
    --     event = "VeryLazy",
    --     config = function ()
                    --         require("trouble").setup {
                        --         }
                        --     end
                        -- },
                        -- {
                            --     "folke/noice.nvim",
                            --     event = "VeryLazy",
                            --     opts = {
                                --         -- add any options here
                                --     },
                                --     dependencies = {
                                    --         -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
                                    --         "MunifTanjim/nui.nvim",
                                    --         -- OPTIONAL:
                                    --         --   `nvim-notify` is only needed, if you want to use the notification view.
                                    --         --   If not available, we use `mini` as the fallback
                                    --         "rcarriga/nvim-notify",
                                    --     }
                                    -- },
                                    -- {
                                        --     "vhyrro/luarocks.nvim",
                                        --     priority = 1000, -- We'd like this plugin to load first out of the rest
                                        --     config = true, -- This automatically runs `require("luarocks-nvim").setup()`
                                        -- },
                                        -- {
                                            --     "nvim-neorg/neorg",
                                            --     event = "VeryLazy",
                                            --     -- lazy = false,
                                            --     version = "*",
                                            --     config = function()
                                                --         require('neorg').setup {
                                                    --             load = {
                                                        --                 ["core.defaults"] = {}, -- Loads default behaviour
                                                        --                 ["core.concealer"] = {}, -- Adds pretty icons to your documents
                                                        --                 ["core.completion"] = {
                                                            --                     config = {
                                                                --                         engine = "nvim-cmp",
                                                                --                     }
                                                                --                 },
                                                                --                 ["core.dirman"] = { -- Manages Neorg workspaces
                                                                    --                     config = {
                                                                        --                         workspaces = {
                                                                            --                             notes = "~/notes",
                                                                            --                         },
                                                                            --                         default_workspace = "notes",
                                                                            --                     },
                                                                            --                 },
                                                                            --             },
                                                                            --         }
                                                                            --         vim.wo.foldlevel = 99
                                                                            --         vim.wo.conceallevel = 2
                                                                            --     end,
                                                                            -- },
                                                                            -- {
                                                                                --     "christoomey/vim-tmux-navigator",
                                                                                --     cmd = {
                                                                                    --         "TmuxNavigateLeft",
                                                                                    --         "TmuxNavigateDown",
                                                                                    --         "TmuxNavigateUp",
                                                                                    --         "TmuxNavigateRight",
                                                                                    --         "TmuxNavigatePrevious",
                                                                                    --     },
                                                                                    --     keys = {
                                                                                        --         { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
                                                                                        --         { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
                                                                                        --         { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
                                                                                        --         { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
                                                                                        --         { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
                                                                                        --     },
                                                                                        -- }
                                                                                        -- {
                                                                                            --     "dstein64/vim-startuptime",
                                                                                            --     -- lazy-load on a command
                                                                                            --     cmd = "StartupTime",
                                                                                            --     -- init is called during startup. Configuration for vim plugins typically should be set in an init function
                                                                                            --     init = function()
                                                                                                --         vim.g.startuptime_tries = 10
                                                                                                --     end,
                                                                                                -- },
