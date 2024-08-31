require("setting")

vim.g.python3_host_prog = "~/.vimenv/bin/python"
vim.g.python2_host_prog = "/usr/local/solido/virtualenvs/10.0.1/bin/python"

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup(
    "plugins"
)

require("keymap")

local neogit = require('neogit')
neogit.setup {}
