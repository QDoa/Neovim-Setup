return {
    'kevinhwang91/nvim-ufo',
    dependencies = 'kevinhwang91/promise-async',
    config = function ()
        -- vim.o.foldcolumn = '1' -- '0' is not bad
        vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
        vim.o.foldlevelstart = 99
        vim.o.foldenable = true

        -- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
        vim.keymap.set('n', 'zR', require('ufo').openAllFolds, { desc = "Open all folds"})
        vim.keymap.set('n', 'zM', require('ufo').closeAllFolds, { desc = "Close all folds"})
        vim.keymap.set('n', 'zK', function ()
            local winid = require('ufo').peekFoldedLinesUnderCursor()
            if not winid then
                vim.lsp.buf.hover()
            end
        end, { desc = "Peek Fold"})

        -- Option 3: treesitter as a main provider instead
        -- (Note: the `nvim-treesitter` plugin is *not* needed.)
        -- ufo uses the same query files for folding (queries/<lang>/folds.scm)
        -- performance and stability are better than `foldmethod=nvim_treesitter#foldexpr()`
        require('ufo').setup({
            provider_selector = function(bufnr, filetype, buftype)
                return {'lsp', 'indent'}
            end
        })
    end
}
