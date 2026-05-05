return {
  'tronikelis/ts-autotag.nvim',
  event = 'InsertEnter',
  config = function()
    require('ts-autotag').setup {
      enable_close = true,
      enable_rename = true,
      enable_close_on_slash = false,
    }
  end,
}
