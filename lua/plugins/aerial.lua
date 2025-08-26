return {
  'stevearc/aerial.nvim',
  opts = {
    -- Automatically open when entering a buffer with symbols
    on_attach = function(bufnr)
      -- Optional: You can set buffer-local mappings here
      vim.keymap.set('n', '<leader>ae', '<cmd>AerialToggle!<cr>', { buffer = bufnr, desc = 'Toggle Aerial outline' })
    end,
    -- Backends to fetch symbols (LSP is default, Treesitter fallback is nice)
    backends = { 'lsp', 'treesitter', 'markdown', 'man' },
    -- Where to open the window
    layout = {
      default_direction = 'right', -- sidebar on the right
      min_width = 30,
    },
    -- Filter symbols if you only want certain kinds
    filter_kind = false, -- or e.g. { "Class", "Function", "Method" }
  },
  keys = {
    { '<leader>ae', '<cmd>AerialToggle!<cr>', desc = 'Toggle Aerial outline' },
  },
}
