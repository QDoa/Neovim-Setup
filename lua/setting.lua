vim.g.python3_host_prog = "~/.vimenv/bin/python"
vim.g.python2_host_prog = "/usr/local/solido/virtualenvs/10.0.1/bin/python"

vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
--vim.opt.mouse = a
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.wrap = false

vim.opt.swapfile = false

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.scrolloff = 8

vim.opt.updatetime = 50
vim.opt.colorcolumn = "120"

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.clipboard:append("unnamedplus")
vim.opt.isfname:append("@-@")
vim.opt.signcolumn = "yes"

vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    callback = function()
        vim.hl.on_yank()
    end,
})
--vim.cmd([[
--" my filetype file
--if exists("did_load_filetypes")
--    finish
--endif

--augroup filetypedetect
--    au! BufRead,BufNewFile *.lib                setfiletype liberty
--augroup END
--]])
--vim.cmd([[
--let g:tagbar_sort = 0
--]])
