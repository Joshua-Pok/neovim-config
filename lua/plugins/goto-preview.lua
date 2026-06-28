return {
	'rmagatti/goto-preview',
	keys = {
		{ 'gpd', "<cmd>lua require('goto-preview').goto_preview_definition()<CR>",      desc = 'Preview Definition' },
		{ 'gpt', "<cmd>lua require('goto-preview').goto_preview_type_definition()<CR>", desc = 'Preview Type Definition' },
		{ 'gpi', "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>",  desc = 'Preview Implementation' },
		{ 'gpD', "<cmd>lua require('goto-preview').goto_preview_declaration()<CR>",     desc = 'Preview Declaration' },
		{ 'gpr', "<cmd>lua require('goto-preview').goto_preview_references()<CR>",      desc = 'Preview References' },
		{ 'gP',  "<cmd>lua require('goto-preview').close_all_win()<CR>",                desc = 'Close Previews' },
	},
	config = function()
		require('goto-preview').setup {
			width = 120,
			height = 25,
			default_mappings = false,
			debug = false,
			opacity = nil,
			resizing_mappings = false,
			post_open_hook = nil,
			references = {
				-- Kept in the config function so telescope themes require correctly
				telescope = require('telescope.themes').get_dropdown { hide_preview = false },
			},
			focus_on_open = true,
			dismiss_on_move = false,
			force_close = true,
			bufhidden = 'wipe',
		}
	end,
}
