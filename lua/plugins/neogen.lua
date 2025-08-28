return {
  'danymat/neogen',
  config = function()
    local neogen = require 'neogen'

    neogen.setup {
      enabled = true,
    }

    -- Keymaps
    vim.keymap.set('n', '<leader>ng', neogen.generate, { desc = 'Generate documentation' })
    vim.keymap.set('n', '<leader>nf', function()
      neogen.generate { type = 'func' }
    end, { desc = 'Generate function doc' })
    vim.keymap.set('n', '<leader>nc', function()
      neogen.generate { type = 'class' }
    end, { desc = 'Generate class doc' })
    vim.keymap.set('n', '<leader>nt', function()
      neogen.generate { type = 'type' }
    end, { desc = 'Generate type doc' })
  end,
  -- Uncomment next line if you want to follow only stable versions
  -- version = "*"
}
