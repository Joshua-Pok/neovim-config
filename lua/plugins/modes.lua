-- plugins.lua (Lazy.nvim)
return {
  {
    'mvllow/modes.nvim',
    config = function()
      require('modes').setup {
        colors = {
          bg = '', -- Optional bg param, defaults to Normal hl group
          copy = '#f5c359',
          delete = '#c75c6a',
          change = '#c75c6a', -- Optional param, defaults to delete
          format = '#c79585',
          insert = '#78ccc5',
          replace = '#245361',
          select = '#9745be', -- Optional param, defaults to visual
          visual = '#9745be',
        },
        set_cursor = true,
        set_cursorline = true,
        set_number = true,
        set_signcolumn = true,
      }
    end,
  },
}
