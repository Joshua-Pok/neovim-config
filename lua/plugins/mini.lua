return {
  'echasnovski/mini.nvim',
  version = false, -- always use latest
  config = function()
    -- Smart textobjects
    require('mini.ai').setup()

    -- Move lines/blocks
    require('mini.move').setup()

    -- Toggle between single-line and multi-line
    require('mini.splitjoin').setup()

    -- Align text interactively
    require('mini.align').setup()
  end,
}
