return {
	'lewis6991/hover.nvim',
	init = function()
		-- Set the vim option BEFORE the plugin loads
		vim.o.mousemoveevent = true
	end,
	keys = {
		{
			'K',
			function()
				require('hover').open()
			end,
			desc = 'hover.nvim (open)',
		},
		{
			'gK',
			function()
				require('hover').enter()
			end,
			desc = 'hover.nvim (enter)',
		},
		{
			'<C-p>',
			function()
				require('hover').hover_switch 'previous'
			end,
			desc = 'hover.nvim (previous source)',
		},
		{
			'<C-n>',
			function()
				require('hover').hover_switch 'next'
			end,
			desc = 'hover.nvim (next source)',
		},
		{
			'<MouseMove>',
			function()
				require('hover').mouse()
			end,
			desc = 'hover.nvim (mouse)',
		},
	},
	opts = {
		providers = {
			'hover.providers.lsp',
			'hover.providers.man',
			'hover.providers.dictionary',
		},
		preview_opts = { border = 'rounded' },
		preview_window = false,
		title = true,
		mouse_providers = { 'hover.providers.lsp' },
		mouse_delay = 1000,
	},
	config = function(_, opts)
		-- Your snippet used `.config`, so we manually wrap it here
		require('hover').config(opts)
	end,
}
