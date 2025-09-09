return {
  'AckslD/nvim-neoclip.lua',
  dependencies = {
    -- you'll need at least one of these
    { 'nvim-telescope/telescope.nvim' },
    -- {'ibhagwan/fzf-lua'},
  },
  config = function()
    require('neoclip').setup()
    vim.keymap.set('n', '<leader>y', '<cmd>Telescope neoclip<CR>', { desc = 'Yank History' })
  end,
}
