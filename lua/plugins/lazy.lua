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
        'windwp/nvim-autopairs', opts = {},
    },
    {
        'nvim-lualine/lualine.nvim', opts = {},
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {},
    },
    {
        'puremourning/vimspector',
        lazy = false,
        opts = {},
        config = function ()
            vim.cmd([[
            " Vimspector
            " let g:vimspector_enable_mappings = 'HUMAN'
            nmap <F5> <Plug>VimspectorContinue
            nmap <F3> <Plug>VimspectorStop
            nmap <F4> <Plug>VimspectorRestart
            nmap <F6> <Plug>VimspectorStop
            nmap <F9> <Plug>VimspectorToggleBreakpoint
            nmap <leader><F9> <Plug>VimspectorToggleConditionalBreakpoint
            nmap <F8> <Plug>VimspectorAddFunctionBreakpoint
            nmap <leader><F8> <Plug>VimspectorRunToCursor
            nmap <F10> <Plug>VimspectorStepOver
            nmap <F11> <Plug>VimspectorStepInto
            nmap <F12> <Plug>VimspectorStepOut

            " for normal mode - the word under the cursor
            nmap <Leader>di <Plug>VimspectorBalloonEval
            " for visual mode, the visually selected text
            xmap <Leader>di <Plug>VimspectorBalloonEval

            nmap <LocalLeader><F11> <Plug>VimspectorUpFrame
            nmap <LocalLeader><F12> <Plug>VimspectorDownFrame
            nmap <Leader>B     <Plug>VimspectorBreakpoints
            nmap <Leader>D     <Plug>VimspectorDisassemble
            ]])
        end
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
        "windwp/nvim-autopairs",
        opt = {},
        event = "InsertEnter",
        config = function()
            require("nvim-autopairs").setup({})
            local cmp_autopairs = require('nvim-autopairs.completion.cmp')
            local cmp = require('cmp')
            cmp.event:on(
                'confirm_done',
                cmp_autopairs.on_confirm_done()
            )
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
    {
        "vhyrro/luarocks.nvim",
        priority = 1000, -- We'd like this plugin to load first out of the rest
        config = true, -- This automatically runs `require("luarocks-nvim").setup()`
    },
    {
        "nvim-neorg/neorg",
        lazy = false,
        version = "*",
        config = function()
            require('neorg').setup {
                load = {
                    ["core.defaults"] = {}, -- Loads default behaviour
                    ["core.concealer"] = {}, -- Adds pretty icons to your documents
                    ["core.completion"] = {
                        config = {
                            engine = "nvim-cmp",
                        }
                    },
                    ["core.dirman"] = { -- Manages Neorg workspaces
                        config = {
                            workspaces = {
                                notes = "~/notes",
                            },
                            default_workspace = "notes",
                        },
                    },
                },
            }
            vim.wo.foldlevel = 99
            vim.wo.conceallevel = 2
        end,
    },
    {"tpope/vim-dadbod"},
    {"kristijanhusak/vim-dadbod-ui"},
    {"kristijanhusak/vim-dadbod-completion"},
    {"preservim/tagbar"},
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
    {"RRethy/vim-illuminate"},
}
