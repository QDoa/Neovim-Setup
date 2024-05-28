-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.6',
        -- or                            , branch = '0.1.x',
        requires = { {'nvim-lua/plenary.nvim'} }
    }
    use {"catppuccin/nvim", as = "catppuccin"}

    use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
    use('nvim-treesitter/playground')
    use('theprimeagen/harpoon')
    use('tpope/vim-fugitive')
    -- use('mbbill/undotree')

    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        requires = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},             -- Required
            {                                      -- Optional
            'williamboman/mason.nvim',
            run = function()
                pcall(vim.cmd, 'MasonUpdate')
            end,
        },
        {'williamboman/mason-lspconfig.nvim'}, -- Optional

        -- Autocompletion
        {'hrsh7th/nvim-cmp'},     -- Required
        {'hrsh7th/cmp-nvim-lsp'}, -- Required
        {'L3MON4D3/LuaSnip'},     -- Required
        }
    }
    use {'mfussenegger/nvim-lint'}
    use {'mhartington/formatter.nvim'}
    use('preservim/tagbar')
    use {
        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons', -- optional
        },
    }
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }
    use('lewis6991/gitsigns.nvim')
    use({
        "kdheepak/lazygit.nvim",
        requires = {
            "nvim-lua/plenary.nvim"
        }
    })
    use('puremourning/vimspector')

    use {
        "williamboman/mason.nvim",
    }
    use {
        "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup {} end
    }
    use {
        'numToStr/Comment.nvim',
    }
    use("lukas-reineke/indent-blankline.nvim")
    use('nvim-treesitter/nvim-treesitter-context')
    use({
        "kylechui/nvim-surround",
        tag = "*",
        config = function ()
            require("nvim-surround").setup({})
        end
    })

    -- Database
    use("tpope/vim-dadbod")
    use("kristijanhusak/vim-dadbod-ui")
    use("kristijanhusak/vim-dadbod-completion")
    -- use {
    --     "nvim-neorg/neorg",
    --     config = function()
    --         require('neorg').setup {
    --             load = {
    --                 ["core.defaults"] = {}, -- Loads default behaviour
    --                 ["core.concealer"] = {}, -- Adds pretty icons to your documents
    --                 ["core.dirman"] = { -- Manages Neorg workspaces
    --                 config = {
    --                     workspaces = {
    --                         notes = "~/notes",
    --                     },
    --                 },
    --             },
    --         },
    --     }
    --     end,
    --     run = ":Neorg sync-parsers",
    --     requires = "nvim-lua/plenary.nvim",
    -- }
    use {'kevinhwang91/nvim-ufo', requires = 'kevinhwang91/promise-async'}


    -- TODO's
    use {
        'folke/trouble.nvim',
        requires = 'nvim-tree/nvim-web-devicons',
        config = function ()
            require("trouble").setup {

            }
        end
    }

    use {
        'folke/todo-comments.nvim',
        requires = 'nvim-lua/plenary.nvim',
        config = function ()
            require("todo-comments").setup {

            }
        end
    }
end)
