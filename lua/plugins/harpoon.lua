-- Harpoon plugin configuration
return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local harpoon = require 'harpoon'

    -- REQUIRED setup
    harpoon:setup {}

    -- Key mappings
    -- Add current file to harpoon list
    vim.keymap.set('n', '<leader>a', function()
      harpoon:list():add()
    end, { desc = 'Add file to harpoon' })

    -- Toggle harpoon quick menu
    vim.keymap.set('n', '<C-e>', function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = 'Open harpoon window' })

    -- Quick navigation to specific files
    vim.keymap.set('n', '<leader>1', function()
      harpoon:list():select(1)
    end, { desc = 'Go to harpoon file 1' })
    vim.keymap.set('n', '<leader>2', function()
      harpoon:list():select(2)
    end, { desc = 'Go to harpoon file 2' })
    vim.keymap.set('n', '<leader>3', function()
      harpoon:list():select(3)
    end, { desc = 'Go to harpoon file 3' })
    vim.keymap.set('n', '<leader>4', function()
      harpoon:list():select(4)
    end, { desc = 'Go to harpoon file 4' })

    -- Navigate through harpoon list
    vim.keymap.set('n', '<C-S-P>', function()
      harpoon:list():prev()
    end, { desc = 'Go to previous harpoon file' })
    vim.keymap.set('n', '<C-S-N>', function()
      harpoon:list():next()
    end, { desc = 'Go to next harpoon file' })
  end,
}
