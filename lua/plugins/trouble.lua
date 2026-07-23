return {
  'folke/trouble.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    preview = {
      type = 'split',
      relative = 'win',
      position = 'right',
      size = 0.3,
    },
  },
  keys = {
    {
      '<leader>xt',
      '<cmd>Trouble test toggle<cr>',
      desc = 'Toggle Custom Test Diagnostics (Trouble)',
    },
    -- Standard default keymaps for reference
    {
      '<leader>xx',
      '<cmd>Trouble diagnostics toggle<cr>',
      desc = 'Diagnostics (Trouble)',
    },
    {
      '<leader>xX',
      '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
      desc = 'Buffer Diagnostics (Trouble)',
    },
  },
}
