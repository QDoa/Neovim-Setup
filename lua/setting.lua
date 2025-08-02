vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- vim.g.python3_host_prog = '/usr/bin/python3.10'
-- vim.g.python_host_prog = '/usr/bin/python3.10'

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

vim.opt.wrap = false

vim.opt.swapfile = false

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.scrolloff = 8

vim.opt.updatetime = 50
vim.opt.colorcolumn = "80"

vim.cmd("set clipboard+=unnamedplus")

-- nmap("<leader>gs", vim.cmd.git)
