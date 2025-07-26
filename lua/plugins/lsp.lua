return {
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        config = false,
        init = function()
            -- Disable automatic setup, we are doing it manually
            vim.g.lsp_zero_extend_cmp = 0
            vim.g.lsp_zero_extend_lspconfig = 0
        end,
    },
    {
        'williamboman/mason.nvim',
        config = true,
    },
    -- LSP
    {
        'neovim/nvim-lspconfig',
        cmd = {'LspInfo', 'LspInstall', 'LspStart'},
        event = {'BufReadPre', 'BufNewFile'},
        dependencies = {
            {'williamboman/mason-lspconfig.nvim'},
            {'saghen/blink.cmp'},
            {
                "SmiteshP/nvim-navbuddy",
                dependencies = {
                    "SmiteshP/nvim-navic",
                    "MunifTanjim/nui.nvim"
                },
                opts = { lsp = { auto_attach = true } }
            },
        },
        config = function()
            -- This is where all the LSP shenanigans will live
            local lsp_zero = require('lsp-zero')
            lsp_zero.extend_lspconfig()

            --- if you want to know more about lsp-zero and mason.nvim
            --- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/integrate-with-mason-nvim.md
            lsp_zero.on_attach(function(client, bufnr)
                -- see :help lsp-zero-keybindings
                -- to learn the available actions
                lsp_zero.default_keymaps({buffer = bufnr})
            end)

            local capabilities = require('blink.cmp').get_lsp_capabilities()
            local navbuddy = require("nvim-navbuddy")

            require('mason-lspconfig').setup({
                ensure_installed = {'lua_ls', 'pyright', 'ruff', 'jsonls'},
                handlers = {
                    -- this first function is the "default handler"
                    -- it applies to every language server without a "custom handler"
                    function(server_name)
                        require('lspconfig')[server_name].setup({
                            capabilities = capabilities,
                            on_attach = function(client, bufnr)
                                navbuddy.attach(client, bufnr)
                            end
                        })
                    end,
                    pyright = function()
                        require('lspconfig').pyright.setup{
                            capabilities = capabilities,
                            on_attach = function(client, bufnr)
                                navbuddy.attach(client, bufnr)
                            end,
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
                                    -- pythonPath="/usr/local/solido/virtualenvs/10.0.1/bin/python",
                                    pythonPath=vim.fn.exepath('python'),
                                    stubPath="/usr/local/solido/configurations/10.0.1/lib/python2.7/site-packages/PySide2"
                                }
                            },
                        }
                    end,
                    ruff = function()
                        require('lspconfig').ruff.setup {
                            capabilities = capabilities,
                            trace = 'messages',
                            on_attach = function(client, bufnr)
                                navbuddy.attach(client, bufnr)
                                if client.name == 'ruff' then
                                    client.server_capabilities.hoverProvider = false
                                end
                            end,
                            init_options = {
                                settings = {
                                    args = {
                                        '--preview'
                                    },
                                    lineLength = 120,
                                    log_level = 'debug',
                                }
                            }
                        }
                    end,
                    -- this is the "custom handler" for `lua_ls`
                    lua_ls = function()
                        -- (Optional) Configure lua language server for neovim
                        local lua_opts = lsp_zero.nvim_lua_ls()
                        lua_opts.capabilities = capabilities
                        require('lspconfig').lua_ls.setup({
                            lua_opts,
                            on_attach = function(client, bufnr)
                                navbuddy.attach(client, bufnr)
                            end
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
                python = {'ruff'} -- , 'flake8'
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
    {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
            library = {
                -- See the configuration section for more details
                -- Load luvit types when the `vim.uv` word is found
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
        },
    },
    { "github/copilot.vim"},
    {
        'saghen/blink.cmp',
        dependencies = { 'rafamadriz/friendly-snippets' },

        version = '*',

        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            keymap = { preset = "enter" },
            appearance = {
                nerd_font_variant = 'mono'
            },

            -- (Default) Only show the documentation popup when manually triggered
            completion = {
                documentation = { auto_show = false } ,
                -- list = {
                --     selection = {
                --         preselect = false }
                -- },
            },

            -- Default list of enabled providers defined so that you can extend it
            -- elsewhere in your config, without redefining it, due to `opts_extend`
            sources = {
                default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer' },
                providers = {
                    lazydev = {
                        name = "LazyDev",
                        module = "lazydev.integrations.blink",
                        score_offset = 100,
                    }
                }
            },

            -- See the fuzzy documentation for more information
            fuzzy = { implementation = "prefer_rust_with_warning" }
        },
        opts_extend = { "sources.default" }
    }
}
