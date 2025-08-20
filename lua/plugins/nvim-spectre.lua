return {
  'nvim-pack/nvim-spectre',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = function()
    require('spectre').setup {
      -- Minimal config to avoid conflicts
      color_devicons = true,
      open_cmd = 'vnew',
      live_update = false,
      find_engine = {
        ['rg'] = {
          cmd = 'rg',
          args = {
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
          },
        },
      },
      replace_engine = {
        ['sed'] = {
          cmd = 'sed',
          args = nil,
        },
      },
      default = {
        find = {
          cmd = 'rg',
        },
        replace = {
          cmd = 'sed',
        },
      },
    }
  end,
  keys = {
    {
      '<leader>rr',
      function()
        require('spectre').toggle()
      end,
      desc = 'Toggle Spectre',
    },
    {
      '<leader>rw',
      function()
        require('spectre').open_visual { select_word = true }
      end,
      desc = 'Search current word',
    },
    {
      '<leader>rv',
      function()
        require('spectre').open_visual()
      end,
      mode = 'v',
      desc = 'Search current word',
    },
    {
      '<leader>rf',
      function()
        require('spectre').open_file_search { select_word = true }
      end,
      desc = 'Search on current file',
    },
  },
}
