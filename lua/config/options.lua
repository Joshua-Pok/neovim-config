-- ~/.config/nvim/lua/config/options.lua
-- Vim options and settings

local opt = vim.opt

-- Line numbers
opt.number = true
-- opt.relativenumber = true  -- Uncomment if you want relative line numbers

-- Mouse support
opt.mouse = 'a'

-- Don't show mode in command line (status line shows it)
opt.showmode = false

-- Clipboard integration
vim.schedule(function()
  opt.clipboard = 'unnamedplus'
end)

-- Indentation
opt.breakindent = true

--wildmenu
opt.wildmenu = true
-- Undo history
opt.undofile = true

-- Search settings
opt.ignorecase = true
opt.smartcase = true

-- UI settings
opt.signcolumn = 'yes'
opt.updatetime = 250
opt.timeoutlen = 300
opt.splitright = true
opt.wrap = true
opt.splitbelow = true
opt.relativenumber = true
-- Whitespace visualization
opt.list = true
opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Live substitution preview
opt.inccommand = 'split'

-- Cursor line highlighting
opt.cursorline = true
-- Scrolling
opt.scrolloff = 10

-- Confirmation dialogs
opt.confirm = true
