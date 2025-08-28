-- Lua
return {
  'folke/twilight.nvim',
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  },

  vim.keymap.set('n', '<leader>T', '<cmd>Twilight<cr>', { desc = 'Toggle Twilight' }),
}
