local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({buffer = bufnr})
end)

-- (Optional) Configure lua language server for neovim
-- require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

lsp.setup()

require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = {'pyright', 'ruff_lsp', 'lua_ls'},
    handlers = {
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
                            -- Ignore all files for analysis to exclusively use Ruff for linting
                            ignore = {'*'},
                        }
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
                        -- Any extra CLI arguments for `ruff` go here.
                        args = {},
                    }
                }
            }
        end,
        lua_ls = function()
            local lua_opts = lsp.nvim_lua_ls()
            require('lspconfig').lua_ls.setup(lua_opts)
        end,
    }
})

-- You need to setup `cmp` after lsp-zero
local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

cmp.setup({
    mapping = {
        -- `Enter` key to confirm completion
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),

        -- Ctrl+Space to trigger completion menu
        ['<C-Space>'] = cmp.mapping.complete(),

        -- Navigate between snippet placeholder
        ['<C-f>'] = cmp_action.luasnip_jump_forward(),
        ['<C-b>'] = cmp_action.luasnip_jump_backward(),
    }
})
