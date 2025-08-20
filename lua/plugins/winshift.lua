return {
  'sindrets/winshift.nvim',
  config = function()
    require('winshift').setup()

    -- Keymap to enter Win-Move mode
    vim.keymap.set('n', '<leader>w', '<cmd>WinShift<CR>', { desc = 'WinShift mode' })
  end,
}
