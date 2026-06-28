return {
	'folke/lazydev.nvim',
	ft = 'lua', -- Only load this plugin when opening a Lua file!
	opts = {
		library = {
			{ path = '${3rd}/luv/library', words = { 'vim%.uv' } },
		},
	},
}
