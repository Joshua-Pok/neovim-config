return {
  'sindrets/diffview.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  cmd = { 'DiffviewOpen', 'DiffviewFileHistory' },
  keys = {
    { '<leader>gid', '<cmd>DiffviewOpen<cr>', desc = 'Diffview: open' },
    { '<leader>giD', '<cmd>DiffviewClose<cr>', desc = 'Diffview: close' },
  },
  opts = {
    enhanced_diff_hl = true,
    view = {
      merge_tool = {
        layout = 'diff3_mixed',
      },
    },
  },
}
