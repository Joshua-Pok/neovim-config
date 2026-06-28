return {
	'kevinhwang91/nvim-hlslens',
	event = 'SearchWrapped', -- Custom pseudo-event, but "VeryLazy" or standard loading is usually best here
	opts = {
		calm_down = true,
		nearest_only = true,
		virt_priority = 0,
		nearest_float_when = 'always',
	},
}
