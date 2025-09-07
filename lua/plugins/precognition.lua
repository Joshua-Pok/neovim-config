return {
  'tris203/precognition.nvim',
  event = 'VeryLazy',
  opts = {
    startVisible = false, -- start hidden; toggle when needed
    showBlankVirtLine = true, -- optional: decide if blank lines are shown
    highlightColor = { link = 'Comment' }, -- hint color
    -- You can customize which hints appear and their priority:
    -- hints = {
    --   w = { text = "w", prio = 10 },
    --   b = { text = "b", prio = 9 },
    --   e = { text = "e", prio = 8 },
    -- },
    -- gutterHints = { gg = { text = "gg", prio = 9 } },
    -- disabled_fts = { "markdown" },  -- disable on specific filetypes
  },
  keys = {
    {
      '<leader>ph',
      function()
        local on = require('precognition').toggle()
        vim.notify('Precognition ' .. (on and 'enabled' or 'disabled'))
      end,
      desc = 'Toggle Precognition hints',
    },
    {
      '<leader>pp',
      function()
        require('precognition').peek()
      end,
      desc = 'Peek Precognition hints',
    },
  },
}
