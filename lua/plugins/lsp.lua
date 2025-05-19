return {
    {
        'williamboman/mason.nvim',
        config = true,
    },
    {'williamboman/mason-lspconfig.nvim'},
    {'hrsh7th/cmp-nvim-lsp'},
    {'hrsh7th/nvim-cmp'},
    -- Autocompletion
    -- {
    --     'hrsh7th/nvim-cmp',
    --     event = 'InsertEnter',
    --     dependencies = {
    --         {'neovim/nvim-lspconfig'},
    --         {'hrsh7th/cmp-nvim-lsp'},
    --     },
    --     config = function()
    --         local cmp = require('cmp')
    --
    --         cmp.setup({
    --             mapping = cmp.mapping.preset.insert({
    --                 ['<CR>'] = cmp.mapping.confirm({select = true}),
    --                 ['<C-Space>'] = cmp.mapping.complete(),
    --                 ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    --                 ['<C-d>'] = cmp.mapping.scroll_docs(4),
    --             }),
    --             snippet = {
    --                 expand = function(args)
    --                     require('luasnip').lsp_expand(args.body)
    --                 end,
    --             },
    --             source = cmp.config.sources({
    --                 { name = "nvim_lsp" },
    --                 { name = "neorg" },
    --                 { name = "path" },
    --                 { name = "nvim_lua" },
    --                 { name = "calc" },
    --                 { name = "buffer" },
    --                 { name = "emoji" },
    --             })
    --         })
    --     end
    -- },
    -- LSP
    {
        'neovim/nvim-lspconfig',
        cmd = {'LspInfo', 'LspInstall', 'LspStart'},
        dependencies = {
            {'hrsh7th/cmp-nvim-lsp'},
            {'williamboman/mason-lspconfig.nvim'},
            {'seghen/blink.cmp'}
        },
        config = function()
            local capabilities = require('blink.cmp').get_lsp_capabilities()

            require('mason-lspconfig').setup({
                ensure_installed = {'lua_ls', 'pyright', 'ruff', 'jsonls', 'clangd', 'cssls', 'tailwindcss', 'tsserver', 'eslint'},
                handlers = {
                    -- this first function is the "default handler"
                    -- it applies to every language server without a "custom handler"
                    function(server_name)
                        require('lspconfig')[server_name].setup({capabilities = capabilities})
                    end,
                    tailwindcss = function ()
                        require('lspconfig').tailwindcss.setup({capabilities = capabilities})
                    end,
                    tsserver = function ()
                        require('lspconfig').tsserver.setup({capabilities = capabilities})
                    end,
                    cssls = function ()
                        require('lspconfig').cssls.setup({capabilities = capabilities})
                    end,
                    clangd = function ()
                        require('lspconfig').clangd.setup({capabilities = capabilities})
                    end,
                    arduino_language_server = function ()
                        require('lspconfig').arduino_language_server.setup{
                            filetypes = {'arduino', 'cpp', 'c'},
                            capabilities = capabilities,
                        }
                    end,
                    pyright = function()
                        require('lspconfig').pyright.setup{
                            capabilities = capabilities,
                            settings = {
                                pyright = {
                                    -- Using Ruff's import organizer
                                    disableOrganizeImports = true,
                                    -- analysis = {diagnosticRuleSet = {reportOptionalMemberAccess = "none",}}
                                },
                                python = {
                                    analysis = {
                                        ignore = {'*'}, -- gonna use a linter so don't use diagnostics
                                        typeCheckingMode = 'off',
                                        autoSearchPaths = true,
                                        diagnosticMode = 'openFilesOnly',
                                        useLibraryCodeForTypes = true,
                                        extraPaths = 'src',
                                        autoImportCompletions = true,
                                    },
                                }
                            }
                        }
                    end,
                    ruff_lsp = function()
                        require('lspconfig').ruff_lsp.setup {
                            capabilities = capabilities,
                            on_attach = function(client, bufnr)
                                if client.name == 'ruff_lsp' then
                                    client.server_capabilities.hoverProvider = false
                                end
                            end,
                            init_options = {
                                settings = {
                                    args = {
                                        '--preview'
                                    },
                                }
                            }
                        }
                    end,
                    lua_ls = function()
                        require('lspconfig').lua_ls.setup({
                            capabilities = capabilities,
                        })
                    end,
                }
            })
        end
    },
    -- Linter
    {
        'mfussenegger/nvim-lint',
        event = {
            "BufReadPre",
            "BufNewFile",
            "BufWritePost"
        },
        config = function ()
            local lint = require("lint")

            lint.linters_by_ft = {
                python = {'ruff'} -- , 'flake8'}
            }

            vim.api.nvim_create_autocmd({ "BufWritePost" }, {
                callback = function()

                    -- try_lint without arguments runs the linters defined in `linters_by_ft`
                    -- for the current filetype
                    require("lint").try_lint()

                    -- You can call `try_lint` with a linter name or a list of names to always
                    -- run specific linters, independent of the `linters_by_ft` configuration
                    -- require("lint").try_lint("cspell")
                end,
            })
        end,
    },
    {'github/copilot.vim'},
    { "roobert/tailwindcss-colorizer-cmp.nvim", opts = {} },
    {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
            library = {
                -- See the configuration section for more details
                -- Load luvit types when the `vim.uv` word is found
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
        },
    },
    {
        'saghen/blink.cmp',
        dependencies = {
        "folke/lazydev.nvim",
        },
        version = '1.*',
        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            keymap = {
                ['<CR>'] = { 'accept', 'fallback'}
            },

            appearance = {
                nerd_font_variant = 'mono'
            },

            completion = { documentation = { auto_show = true } },

            sources = {
                default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer', 'path' },
                providers = {
                    lazydev = {
                        name = "LazyDev",
                        module = "lazydev.integrations.blink",
                        -- make lazydev completions top priority (see `:h blink.cmp`)
                        score_offset = 100,
                    },
                },
            },

            fuzzy = { implementation = "prefer_rust_with_warning" }
        },
        signature = { enable = true },
        opts_extend = { "sources.default" }
    },
    {
        "ibhagwan/fzf-lua",
        -- optional for icon support
        dependencies = { "nvim-tree/nvim-web-devicons" },
        -- or if using mini.icons/mini.nvim
        -- dependencies = { "echasnovski/mini.icons" },
        build = 'cargo build --release',
        opts = {}
    }
}
