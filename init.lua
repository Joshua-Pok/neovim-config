-- Set leader keys
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Enable vim loader for faster startup
vim.loader.enable()

-- Set nerd font support
vim.g.have_nerd_font = true

require 'config'
-- Load additional config
require 'config.lazy'
