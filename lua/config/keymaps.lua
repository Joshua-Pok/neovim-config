local keymap = vim.keymap.set

-- Clear search highlights
keymap('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Clear search highlights' })

-- Diagnostic keymaps
keymap('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Terminal mode keymaps
keymap('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
-- Window navigation
keymap('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
keymap('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
keymap('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
keymap('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
keymap('n', '<leader>bn', ':bnext<CR>', { desc = 'Next Buffer' })
keymap('n', '<leader>bp', ':bprevious<CR>', { desc = 'Previous Buffer' })
keymap('n', '<leader>bd', ':bdelete<CR>')
keymap('i', 'jk', '<Esc>', { desc = 'Exit insert mode' })
keymap('n', '<leader>fp', '<cmd>Telescope projects<CR>', { desc = 'find projects' })
keymap('n', 'p', 'p=`]', { desc = 'Paste and auto-indent' })

-- Keep cursor centered when scrolling
keymap('n', '<C-d>', '<C-d>zz', { desc = 'Scroll down centered' })
keymap('n', '<C-u>', '<C-u>zz', { desc = 'Scroll up centered' })
vim.keymap.set('n', '<leader>t', function()
  vim.cmd 'vsplit | wincmd l | terminal'
end, { desc = 'Open terminal on right' })
-- Uncomment these if you want to disable arrow keys in normal mode
-- keymap('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- keymap('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- keymap('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- keymap('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Window movement (uncomment if your terminal supports these keycodes)
-- keymap("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
-- keymap("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
-- keymap("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
-- keymap("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })
--
--
-- vim.keymap.set("n", "<C-h>", "<cmd>TmuxNavigateLeft<CR>")
vim.keymap.set('n', '<C-j>', '<cmd>TmuxNavigateDown<CR>')
vim.keymap.set('n', '<C-k>', '<cmd>TmuxNavigateUp<CR>')
vim.keymap.set('n', '<C-l>', '<cmd>TmuxNavigateRight<CR>')
vim.keymap.set('n', '<C-\\>', '<cmd>TmuxNavigatePrevious<CR>')
