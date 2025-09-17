return {
  'max397574/better-escape.nvim',
  event = 'InsertEnter', -- loads only when entering insert mode
  config = function()
    require('better_escape').setup {
      mapping = { 'jk', 'jj' }, -- keys to use for escaping
      timeout = 200, -- max time (ms) to type the sequence
      clear_empty_lines = false, -- optional, leave empty lines intact
      keys = '<Esc>', -- what to trigger (default is <Esc>)
    }
  end,
}
