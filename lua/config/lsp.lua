-- lua/config/lsp.lua
local M = {}

M.setup = function()
  -- Global diagnostics config
  vim.diagnostic.config {
    virtual_text = false,
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
      border = 'rounded',
      source = 'always',
      header = '',
      prefix = '',
    },
  }

  -- Optional: show float on hover
  vim.api.nvim_create_autocmd('CursorHold', {
    callback = function()
      vim.diagnostic.open_float(nil, { focus = false })
    end,
  })
end

return M
