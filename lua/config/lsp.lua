-- lua/config/lsp.lua
local M = {}

M.setup = function()
  vim.diagnostic.config {
    virtual_text = false,
    signs = {
      -- Show severity icons in the sign column
      text = {
        [vim.diagnostic.severity.ERROR] = '󰅚 ',
        [vim.diagnostic.severity.WARN] = '󰀪 ',
        [vim.diagnostic.severity.INFO] = '󰋽 ',
        [vim.diagnostic.severity.HINT] = '󰌶 ',
      },
    },
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
      -- border is now handled by winborder globally, no need to set here
      source = true, -- 'always' was deprecated, use true instead
      header = '',
      prefix = '',
    },
  }

  vim.api.nvim_create_autocmd('CursorHold', {
    group = vim.api.nvim_create_augroup('diagnostic-float', { clear = true }),
    callback = function()
      vim.diagnostic.open_float(nil, { focus = false })
    end,
  })
end

return M
