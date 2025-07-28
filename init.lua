-- Set leader keys
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Enable vim loader for faster startup
vim.loader.enable()

-- Set nerd font support
vim.g.have_nerd_font = true

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end

-- Add lazy to runtime path
vim.opt.rtp:prepend(lazypath)

-- Enable diagnostics globally
vim.diagnostic.config {
  virtual_text = {
    -- Show all diagnostics as inline virtual text
    source = 'always', -- Show source of diagnostic
    prefix = '●', -- Customize the prefix for virtual text
    format = function(diagnostic)
      return string.format('%s: %s', diagnostic.source, diagnostic.message)
    end,
  },
  signs = true, -- Show signs in the sign column
  update_in_insert = true, -- Update diagnostics even in insert mode
  severity_sort = true, -- Sort diagnostics by severity
  float = {
    source = 'always', -- Show source in floating windows
    border = 'rounded', -- Optional: nicer borders for floating diagnostics
  },
}

-- Setup lazy.nvim
require('lazy').setup({
  { import = 'plugins' },
}, {
  ui = {
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- Load additional config
require 'config'

