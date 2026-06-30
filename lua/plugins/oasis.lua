return {
  'uhs-robert/oasis.nvim',
  lazy = false, -- Make sure we load this during startup
  priority = 1000, -- Load this before all other start plugins
  config = function()
    require('oasis').setup { transparent = true }
    vim.cmd.colorscheme 'oasis-midnight'
  end,
}
