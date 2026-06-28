return {
  'folke/todo-comments.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = {
    -- You can add custom configuration here.
    -- Leaving it empty as {} will use the default settings.
  },
  -- Optional: add keybindings right in the Lazy spec
  keys = {
    {
      ']t',
      function()
        require('todo-comments').jump_next()
      end,
      desc = 'Next todo comment',
    },
    {
      '[t',
      function()
        require('todo-comments').jump_prev()
      end,
      desc = 'Previous todo comment',
    },
    { '<leader>xt', '<cmd>TodoTelescope<cr>', desc = 'Todo Telescope' },
  },
}
