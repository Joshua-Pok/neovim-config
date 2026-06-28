return {
	'lukas-reineke/indent-blankline.nvim',
	main = 'ibl', -- Tells lazy.nvim to require('ibl') instead of require('indent-blankline')
	event = { 'BufReadPre', 'BufNewFile' },
	opts = {},
}
