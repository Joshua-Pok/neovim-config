return {
  'maelwalser/oil-copy.nvim',
  dependencies = { 'stevearc/oil.nvim' },
  opts = {
    -- You can customize the keymap here
    -- keymap = "<leader>p" -- Uncomment and change to your preferred key
  },
  config = function()
    require('oil-copy').setup()
  end,
}
