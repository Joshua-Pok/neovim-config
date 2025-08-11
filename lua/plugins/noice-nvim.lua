return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  opts = {
    -- add any options here
  },
  dependencies = {
    'MunifTanjim/nui.nvim',
    {
      'rcarriga/nvim-notify',
      config = function()
        require('notify').setup {
          background_colour = '#000000', -- solid black to stop the warning
        }
        vim.notify = require 'notify' -- hook into vim.notify
      end,
    },
  },
}

