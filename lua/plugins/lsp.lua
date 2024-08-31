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
    -- Autocompletion
    {
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
        dependencies = {
            {'L3MON4D3/LuaSnip'},
        },
        config = function()
            -- Here is where you configure the autocompletion settings.
            local lsp_zero = require('lsp-zero')
            lsp_zero.extend_cmp()

            -- And you can configure cmp even more, if you want to.
            local cmp = require('cmp')
            local cmp_action = lsp_zero.cmp_action()

            cmp.setup({
                formatting = lsp_zero.cmp_format({details = true}),
                mapping = cmp.mapping.preset.insert({
                    ['<CR>'] = cmp.mapping.confirm({select = true}),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-d>'] = cmp.mapping.scroll_docs(4),
                    ['<C-f>'] = cmp_action.luasnip_jump_forward(),
                    ['<C-b>'] = cmp_action.luasnip_jump_backward(),
                }),
                snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body)
                    end,
                },
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "neorg" },
                    { name = "path" },
                    { name = "nvim_lua" },
                    { name = "calc" },
                    { name = "buffer" },
                    { name = "emoji" },
                })
            })
        end
    },
    -- LSP
    {
        'neovim/nvim-lspconfig',
        cmd = {'LspInfo', 'LspInstall', 'LspStart'},
        event = {'BufReadPre', 'BufNewFile'},
        dependencies = {
            {'hrsh7th/cmp-nvim-lsp'},
            {'williamboman/mason-lspconfig.nvim'},
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

            require('mason-lspconfig').setup({
                ensure_installed = {'lua_ls', 'pyright', 'ruff_lsp', 'jsonls'},
                handlers = {
                    -- this first function is the "default handler"
                    -- it applies to every language server without a "custom handler"
                    function(server_name)
                        require('lspconfig')[server_name].setup({})
                    end,
                    pyright = function()
                        require('lspconfig').pyright.setup{
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
                            }
                        }
                    end,
                    ruff_lsp = function()
                        require('lspconfig').ruff_lsp.setup {
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
                    -- this is the "custom handler" for `lua_ls`
                    lua_ls = function()
                        -- (Optional) Configure lua language server for neovim
                        local lua_opts = lsp_zero.nvim_lua_ls()
                        require('lspconfig').lua_ls.setup(lua_opts)
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
    }
}
