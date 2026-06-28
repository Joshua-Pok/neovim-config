return {
	{
		'rcarriga/nvim-notify',
		lazy = true,
		-- lazy.nvim automatically passes the `opts` table into the `config` function
		opts = {
			background_colour = '#000000',
		},
		config = function(_, opts)
			require('notify').setup(opts)
			vim.notify = require 'notify'
		end,
	},

	{
		'folke/noice.nvim',
		event = 'VeryLazy',
		dependencies = {
			'MunifTanjim/nui.nvim',
			'rcarriga/nvim-notify',
		},
		opts = {
			-- You can add your noice configuration options here
		},
	},
}
