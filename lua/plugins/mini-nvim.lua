return {
  {
    'echasnovski/mini.nvim',
    version = false, -- Use the latest development features
    config = function()
      -- 1. Automatic pairs insertion as you type
      require('mini.pairs').setup {}

      -- 2. Move lines and visual selections seamlessly
      require('mini.move').setup {
        mappings = {
          -- Move lines in Normal mode
          left = '<M-h>',
          right = '<M-l>',
          down = '<M-j>',
          up = '<M-k>',

          -- Move selections in Visual mode
          line_left = '<M-h>',
          line_right = '<M-l>',
          line_down = '<M-j>',
          line_up = '<M-k>',
        },
      }

      -- 3. Add, delete, and replace surroundings
      require('mini.surround').setup {}
      require('mini.diff').setup {}

      -- 4. Smooth animations for scrolling, cursor, and windows
      require('mini.animate').setup {}
      require('mini.operators').setup {}
      require('mini.misc').setup_auto_root {}

      -- 5. File manager (mini.files)
      require 'mini.files'
      require('mini.indentscope').setup {
        symbol = '│',
        options = { try_as_border = true },
      }
      require('mini.icons').setup {}

      require('mini.hipatterns').setup {}

      -- Keymap to open mini.files
      vim.keymap.set('n', '-', function()
        -- Opens mini.files in the directory of the currently active buffer
        require('mini.files').open(vim.api.nvim_buf_get_name(0), true)
      end, { desc = 'Open mini.files (Directory of current file)' })
    end,
  },
}
