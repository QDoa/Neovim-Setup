local capabilities = require('blink.cmp').get_lsp_capabilities()

vim.lsp.config('ruff', {
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
            -- pythonPath="/usr/local/solido/virtualenvs/10.0.1/bin/python",
            pythonPath=vim.fn.exepath('python'),
            stubPath="/usr/local/solido/configurations/10.0.1/lib/python2.7/site-packages/PySide2"
        }
    },
    on_attach = on_attach,

})

vim.lsp.config('ruff', {
    capabilities = capabilities,
    trace = 'messages',
    on_attach = on_attach,
    init_options = {
        settings = {
            args = {
                '--preview'
            },
            lineLength = 120,
            log_level = 'debug',
        }
    }
})

vim.lsp.config('lua_ls', {
    capabilities = capabilities,
    on_attach = on_attach,
})

vim.lsp.enable('ruff')
vim.lsp.enable('lua_ls')
vim.lsp.enable('pyright')

return {
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
                    {
                        "SmiteshP/nvim-navic",
                        opts = { lsp = { auto_attach = true } }
                    },
                    "MunifTanjim/nui.nvim"
                },
                opts = { lsp = { auto_attach = true } }
            },
        },
    },
}
