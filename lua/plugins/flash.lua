return {
	'folke/flash.nvim',
	event = 'VeryLazy',
	opts = {
		modes = {
			char = {
				jump_labels = true,
				multi_line = false,
			}
		},
		search = {
			multi_window = false,
			forward = true,
		},
		label = {
			uppercase = false,
		},
		prompt = {
			enabled = true,
			prefix = { { " FLASH ", "FlashPromptIcon" } },
		}
	},
	keys = {
		{
			's',
			mode = { 'n', 'x', 'o' },
			function()
				require('flash').jump()
			end,
			desc = 'Flash',
		},
		{
			'S',
			mode = { 'n', 'x', 'o' },
			function()
				require('flash').treesitter()
			end,
			desc = 'Flash Treesitter',
		},
		{
			'r',
			mode = 'o',
			function()
				require('flash').remote()
			end,
			desc = 'Remote Flash',
		},
		{
			'R',
			mode = { 'o', 'x' },
			function()
				require('flash').treesitter_search()
			end,
			desc = 'Treesitter Search',
		},
		{
			'<c-s>',
			mode = { 'c' },
			function()
				require('flash').toggle()
			end,
			desc = 'Toggle Flash Search',
		},
	},
}
