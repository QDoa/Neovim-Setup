-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.5',
        -- or                            , branch = '0.1.x',
        requires = { {'nvim-lua/plenary.nvim'} }
    }
    use { "catppuccin/nvim", as = "catppuccin" }

    use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
    use('nvim-treesitter/playground')
    use('theprimeagen/harpoon')
    use('tpope/vim-fugitive')
    use('mbbill/undotree')
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

    use {
        "williamboman/mason.nvim",
        "jay-babu/mason-nvim-dap.nvim",
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

    use('puremourning/vimspector')

    -- use {
    --     "nvim-neorg/neorg",
    --     config = function()
    --         require('neorg').setup {
    --             load = {
    --                 ["core.defaults"] = {}, -- Loads default behaviour
    --                 ["core.concealer"] = {}, -- Adds pretty icons to your documents
    --                 ["core.qol.toc"] = {},
    --                 ["core.completion"] = {
    --                     config = {
    --                         engine = "nvim-cmp",
    --                     },
    --                 }, -- A wrapper to interface with several different completion
    --                 ["core.dirman"] = { -- Manages Neorg workspaces
    --                 config = {
    --                     workspaces = {
    --                         notes = "~/notes",
    --                         project = "~/notes/project"
    --                     },
    --                 },
    --             },
    --         },
    --     }end,
    --     run = ":Neorg sync-parsers",
    --     requires = "nvim-lua/plenary.nvim",
    -- }
    use {'kevinhwang91/nvim-ufo', requires = 'kevinhwang91/promise-async'}
end)
