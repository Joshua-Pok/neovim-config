return {
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    opts = {
      -- 1. Performance boosts
      bigfile = { enabled = true },
      quickfile = { enabled = true },

      -- 2. Visual improvements (Pairs beautifully with your Noice setup)
      notifier = { enabled = true, timeout = 3000 },

      scratch = { enabled = true },
    },
    keys = {
      -- Open a scratch buffer (Defaults to markdown, or changes via filetype)
      {
        '<leader>sb',
        function()
          Snacks.scratch()
        end,
        desc = 'Toggle Scratch Buffer',
      },
      {
        '<leader>sS',
        function()
          Snacks.scratch.select()
        end,
        desc = 'Select Scratch Buffer',
      },
      -- Check notification history
      {
        '<leader>nh',
        function()
          Snacks.notifier.show_history()
        end,
        desc = 'Notification History',
      },
    },
  },
}
