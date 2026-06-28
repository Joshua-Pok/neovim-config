return {
  'chrisgrieser/nvim-origami',
  event = { 'BufReadPost', 'BufNewFile' },
  init = function()
    -- Set these BEFORE the plugin loads
    vim.opt.foldlevel = 99
    vim.opt.foldlevelstart = 99
  end,
  opts = {},
}
