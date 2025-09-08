-- lua/plugins/hover.lua
return {
  'lewis6991/hover.nvim',
  event = 'VeryLazy',
  -- pass the plugin options here so lazy.nvim hands them to the config function
  opts = {
    providers = {
      'hover.providers.lsp',
      'hover.providers.man',
      'hover.providers.dictionary',
    },
    preview_opts = {
      border = 'rounded',
    },
    preview_window = false,
    title = true,
    mouse_providers = { 'hover.providers.lsp' },
    mouse_delay = 1000,
  },
  config = function(_, opts)
    -- use the new API
    require('hover').config(opts)

    -- open hover (shows providers according to priority)
    vim.keymap.set('n', 'K', function()
      require('hover').open()
    end, { desc = 'hover.nvim (open)' })

    -- enter hover window (focus it so you can scroll with j/k, C-d, etc.)
    vim.keymap.set('n', 'gK', function()
      require('hover').enter()
    end, { desc = 'hover.nvim (enter)' })

    -- switch provider (previous / next)
    vim.keymap.set('n', '<C-p>', function()
      require('hover').hover_switch 'previous'
    end, { desc = 'hover.nvim (previous source)' })
    vim.keymap.set('n', '<C-n>', function()
      require('hover').hover_switch 'next'
    end, { desc = 'hover.nvim (next source)' })

    -- mouse support (uses the new mouse() function)
    vim.keymap.set('n', '<MouseMove>', function()
      require('hover').mouse()
    end, { desc = 'hover.nvim (mouse)' })
    vim.o.mousemoveevent = true
  end,
}
