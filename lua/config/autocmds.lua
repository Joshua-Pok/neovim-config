-- ==========================================================================
-- 1. UTILITY & CORE (Optimised)
-- ==========================================================================

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank() -- modern, clean
  end,
})

-- Remove trailing whitespace on save (Cursor bug fixed)
vim.api.nvim_create_autocmd('BufWritePre', {
  desc = 'Remove trailing whitespace on save',
  group = vim.api.nvim_create_augroup('trailing-whitespace', { clear = true }),
  callback = function()
    local pos = vim.api.nvim_win_get_cursor(0)
    -- Guard: check total line count to prevent cursor out-of-bounds error
    local line_count = vim.api.nvim_buf_line_count(0)
    vim.cmd [[%s/\s\+$//e]]
    local new_line_count = vim.api.nvim_buf_line_count(0)

    -- If removing trailing lines changes file size, safely clamp the cursor position
    if pos[1] > new_line_count then
      pos[1] = new_line_count
    end
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

-- Fix for Help Windows (Pattern and type bug fixed)
vim.api.nvim_create_autocmd('BufWinEnter', {
  desc = 'Move help windows to vertical split on the right',
  group = vim.api.nvim_create_augroup('help-window-right', { clear = true }),
  pattern = '*', -- Help files are actually .txt files, but match all to catch them reliably
  callback = function()
    if vim.bo.buftype == 'help' then
      vim.cmd 'wincmd L'
    end
  end,
})

-- Automatically enter insert mode when terminal opens
vim.api.nvim_create_autocmd('TermOpen', {
  desc = 'Auto-insert mode in terminal',
  group = vim.api.nvim_create_augroup('terminal-autoinsert', { clear = true }),
  callback = function()
    vim.cmd 'startinsert'
  end,
})

-- ==========================================================================
-- 2. APPEARANCE & THEMING
-- ==========================================================================

-- Persistent colorscheme updates (Grouped properly)
vim.api.nvim_create_autocmd('ColorScheme', {
  desc = 'Persistent CursorLine styling across color changes',
  group = vim.api.nvim_create_augroup('colorscheme-tweaks', { clear = true }),
  callback = function()
    vim.api.nvim_set_hl(0, 'CursorLine', { bg = '#1e2a3a' })
  end,
})

-- Cat Emoji Right-Align (Performance optimized)
local cursor_ns = vim.api.nvim_create_namespace 'cursor_emoji'
vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
  desc = 'Right-aligned cursor companion emoji',
  group = vim.api.nvim_create_augroup('cursor-companion', { clear = true }),
  callback = function()
    vim.api.nvim_buf_clear_namespace(0, cursor_ns, 0, -1)
    local row = vim.api.nvim_win_get_cursor(0)[1] - 1

    -- Performance check: skip massive files to keep editor responsive
    if vim.api.nvim_buf_line_count(0) > 10000 then
      return
    end

    vim.api.nvim_buf_set_extmark(0, cursor_ns, row, 0, {
      virt_text = { { '🐱   ', 'Normal' } },
      virt_text_pos = 'right_align',
    })
  end,
})

-- ==========================================================================
-- 3. FORMATTING & AUTOSAVE (Performance Fixes)
-- ==========================================================================

-- Debounced formatting and typing throttle
local format_timer = nil
vim.api.nvim_create_autocmd({ 'InsertLeave', 'TextChanged' }, {
  desc = 'Throttled formatting and autosave on typing',
  group = vim.api.nvim_create_augroup('autosave-format', { clear = true }),
  callback = function()
    if vim.bo.modified and vim.bo.buftype == '' and vim.fn.expand '%' ~= '' then
      -- Debounce: cancel pending actions so it doesn't run on EVERY character strike
      if format_timer then
        format_timer:stop()
      end

      format_timer = vim.defer_fn(function()
        -- Ensure buffer wasn't closed or saved during delay
        if not vim.api.nvim_buf_is_valid(0) or not vim.bo.modified then
          return
        end

        vim.lsp.buf.format {
          async = false, -- Must be synchronous right before write
          filter = function(client)
            if vim.bo.filetype == 'python' then
              return client.name == 'ruff'
            end
            return client.name ~= 'ts_ls'
          end,
        }
        vim.cmd 'silent! write'
      end, 1000) -- Delays execution for 1000ms after you stop moving/typing
    end
  end,
})
