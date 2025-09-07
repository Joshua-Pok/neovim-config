return {
  'Wansmer/treesj',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  keys = {
    { '<leader>j', '<cmd>TSJToggle<cr>', desc = 'Toggle Join/Split' },
  },
  config = function()
    require('treesj').setup {
      use_default_keymaps = false, -- we’re defining our own
      max_join_length = 150, -- max line length to join
      cursor_behavior = 'start', -- keep cursor at start of node
    }
  end,
}
