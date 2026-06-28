return {
	{
		'amansingh-afk/milli.nvim',
		lazy = false,
	},

	{
		'goolord/alpha-nvim',
		dependencies = {
			'amansingh-afk/milli.nvim',
		},
		lazy = false,
		config = function()
			local alpha = require 'alpha'
			local dashboard = require 'alpha.themes.dashboard'
			local milli = require 'milli'

			local splash = milli.load {
				splash = 'vibecat',
				loop = true,
			}

			dashboard.section.header.val = splash.frames[1]
			dashboard.section.header.opts.hl = 'AlphaHeader'

			milli.alpha {
				splash = 'vibecat',
				loop = true,
			}

			dashboard.section.buttons.val = {
				dashboard.button('f', '󰈙  Find file', ':Telescope find_files<CR>'),
				dashboard.button('r', '󰋚  Recent files', ':Telescope oldfiles<CR>'),
				dashboard.button('g', '󰈬  Find text', ':Telescope live_grep<CR>'),
				dashboard.button('p', '󰙅  Projects', ':Telescope projects<CR>'),
				dashboard.button('q', '󰗼  Quit', ':qa<CR>'),
			}

			alpha.setup(dashboard.opts)
		end,
	},
}
