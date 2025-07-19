return  {
    'folke/persistence.nvim',
    event = 'BufReadPre', -- this will only start session saving when an actual file was opened
    opts = {
      dir = vim.fn.stdpath 'data' .. '/sessions',
      options = { 'buffers', 'curdir', 'tabpages', 'winsize', 'help', 'globals' },
      pre_save = function()
        vim.api.nvim_exec_autocmds('User', { pattern = 'SessionSavePre' })
      end,
      save_empty = false,
    },
    keys = {
      {
        '<leader>ss',
        function()
          require('persistence').save()
        end,
        desc = 'Save Session',
      },
      {
        '<leader>sl',
        function()
          require('persistence').load()
        end,
        desc = 'Load Session',
      },
      {
        '<leader>sL',
        function()
          require('persistence').load { last = true }
        end,
        desc = 'Load Last Session',
      },
      {
        '<leader>sd',
        function()
          require('persistence').stop()
        end,
        desc = 'Stop Sesion Autosave',
      },
    },
    config = function(_, opts)
      require('persistence').setup(opts)
      vim.api.nvim_create_autocmd('VimEnter', {
        callback = function()
          if vim.fn.argc() == 0 then
            require('persistence').load()
          end
        end,
      })
    end,
  }