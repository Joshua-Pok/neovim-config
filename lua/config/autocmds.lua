-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Auto-start treesitter highlighting
vim.api.nvim_create_autocmd('FileType', {
  callback = function()
    local ok, _ = pcall(vim.treesitter.start)
    if not ok then
      -- fallback to legacy syntax if no parser available
      vim.cmd 'syntax on'
    end
  end,
})

-- Remove trailing whitespace on save
vim.api.nvim_create_autocmd('BufWritePre', {
  desc = 'Remove trailing whitespace on save',
  group = vim.api.nvim_create_augroup('trailing-whitespace', { clear = true }),
  callback = function()
    local pos = vim.api.nvim_win_get_cursor(0)
    vim.cmd [[%s/\s\+$//e]]
    vim.api.nvim_win_set_cursor(0, pos)
  end,
})

-- Restore cursor position when reopening a file
vim.api.nvim_create_autocmd('BufReadPost', {
  desc = 'Restore cursor position',
  group = vim.api.nvim_create_augroup('restore-cursor', { clear = true }),
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    if mark[1] > 0 and mark[1] <= vim.api.nvim_buf_line_count(0) then
      vim.api.nvim_win_set_cursor(0, mark)
    end
  end,
})

vim.api.nvim_create_autocmd('ColorScheme', {
  callback = function()
    vim.api.nvim_set_hl(0, 'CursorLine', { bg = '#1e2a3a' })
  end,
})

local cursor_ns = vim.api.nvim_create_namespace 'cursor_emoji'

vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
  callback = function()
    vim.api.nvim_buf_clear_namespace(0, cursor_ns, 0, -1)
    local row = vim.api.nvim_win_get_cursor(0)[1] - 1
    vim.api.nvim_buf_set_extmark(0, cursor_ns, row, 0, {
      virt_text = { { '🐱   ', 'Normal' } },
      virt_text_pos = 'right_align',
    })
  end,
})
