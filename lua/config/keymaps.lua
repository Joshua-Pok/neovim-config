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
