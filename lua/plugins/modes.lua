-- In your lazy.nvim setup file (usually plugins.lua)
return {
  {
    'echasnovski/mini.nvim', -- modes.nvim is part of the mini.nvim ecosystem
    version = false, -- latest commit
    config = function()
      require('mini.cursorword').setup() -- optional: for cursorword highlighting
      require('mini.animate').setup() -- optional: for smooth animations
      -- For modes.nvim specifically:
      require('modes').setup()
    end,
  },
  {
    'mvllow/modes.nvim',
    config = function()
      require('modes').setup()
    end,
  },
}
