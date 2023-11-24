vim.cmd("let g:vimspector_enable_mappings = 'HUMAN'")

vim.keymap.set('n', '<Leader>di', '<Plug>VimsperctorBalloonEval')
vim.keymap.set('x', '<Leader>di', '<Plug>VimsperctorBalloonEval')
