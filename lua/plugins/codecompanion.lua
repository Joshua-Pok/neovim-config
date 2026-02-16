return {
  'olimorris/codecompanion.nvim',
  version = '^18.0.0',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  opts = {
    adapters = {
      http = {
        openai = function()
          return require('codecompanion.adapters').extend('openai', {
            env = {
              api_key = 'OPENAI_API_KEY', -- reads from your environment
            },
            -- optional: set a default model
            schema = {
              model = {
                default = 'gpt-4.1-mini',
              },
            },
          })
        end,
      },
    },

    strategies = {
      chat = {
        adapter = {
          name = 'openai',
          model = 'gpt-4.1-mini',
        },
      },
      inline = { adapter = 'openai' },
      cmd = { adapter = 'openai' },
    },

    opts = {
      log_level = 'DEBUG',
    },
  },
}
