return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	keys = {
		{'<leader>n', '<cmd>NvimTreeFocus<cr>', mode = 'n'},
		{'<C-n>', '<cmd>NvimTreeOpen<cr>', mode = 'n'},
		{'<C-t>', '<cmd>NvimTreeToggle<cr>', mode = 'n'},
		{'<C-f>', '<cmd>NvimTreeFind<cr>', mode = 'n'},
	},
	config = function()
		require("nvim-tree").setup {
			view = {
				side = "right",
			}
		}
	end,
}
