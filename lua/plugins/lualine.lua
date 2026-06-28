return {
  'nvim-lualine/lualine.nvim',
  event = 'VeryLazy',
  opts = {
    options = { theme = 'horizon' },
    sections = {
      lualine_c = { { 'filename', path = 2 } },
    },
  },
}
