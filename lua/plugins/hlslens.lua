return {
  'kevinhwang91/nvim-hlslens',
  event = 'BufReadPost',
  config = function()
    require('hlslens').setup {
      calm_down = true, -- less distracting highlighting
      nearest_only = true, -- only highlight nearest match
      virt_priority = 0,
      nearest_float_when = 'always',
    }
  end,
}
