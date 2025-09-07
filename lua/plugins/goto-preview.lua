return {
  'rmagatti/goto-preview',
  config = function()
    require('goto-preview').setup {
      width = 120, -- Width of the floating window
      height = 25, -- Height of the floating window
      default_mappings = false, -- we’ll set our own mappings
      debug = false,
      opacity = nil,
      resizing_mappings = false,
      post_open_hook = nil,
      references = {
        telescope = require('telescope.themes').get_dropdown { hide_preview = false },
      },
      focus_on_open = true,
      dismiss_on_move = false,
      force_close = true,
      bufhidden = 'wipe',
    }

    -- Key mappings
    local map = vim.keymap.set
    local opts = { noremap = true, silent = true }

    map('n', 'gpd', "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", opts)
    map('n', 'gpt', "<cmd>lua require('goto-preview').goto_preview_type_definition()<CR>", opts)
    map('n', 'gpi', "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>", opts)
    map('n', 'gpD', "<cmd>lua require('goto-preview').goto_preview_declaration()<CR>", opts)
    map('n', 'gpr', "<cmd>lua require('goto-preview').goto_preview_references()<CR>", opts)
    map('n', 'gP', "<cmd>lua require('goto-preview').close_all_win()<CR>", opts)
  end,
}
